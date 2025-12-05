package controllers

import (
	"context"
	"html/template"
	"log"
	"net/http"
	"strconv"
	"strings"
	"time"

	database "trabalhon-n2/db"
	"trabalhon-n2/helpers"

	"github.com/google/uuid"
	"github.com/gorilla/mux"
)

type GameController struct {
	queries   *database.Queries
	templates *template.Template
}

// NewGameController inicializa o controller com queries e templates pre-carregados
func NewGameController() *GameController {
	tmpl := template.Must(template.ParseGlob("views/**/*.html"))

	return &GameController{
		queries:   database.New(helpers.DB),
		templates: tmpl,
	}
}

// validateGameInput valida os dados do game
func validateGameInput(name, hostIDStr string) []string {
	var errors []string

	if len(strings.TrimSpace(name)) < 3 {
		errors = append(errors, "Game name must be at least 3 characters")
	}

	if _, err := uuid.Parse(hostIDStr); err != nil {
		errors = append(errors, "Invalid host ID")
	}

	return errors
}

// renderGameTemplate renderiza um template com tratamento de erro
func (gc *GameController) renderGameTemplate(w http.ResponseWriter, templateName string, data interface{}) {
	// First execute the base layout, which will call the content template
	if err := gc.templates.ExecuteTemplate(w, "base", data); err != nil {
		log.Printf("Error rendering template %s: %v", templateName, err)
		http.Error(w, "Internal Server Error", http.StatusInternalServerError)
	}
}

// Index lista todas as salas de games (GET /games)
func (gc *GameController) Index(w http.ResponseWriter, r *http.Request) {
	ctx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
	defer cancel()

	// Parse query parameters for pagination
	limitStr := r.URL.Query().Get("limit")
	offsetStr := r.URL.Query().Get("offset")
	statusStr := r.URL.Query().Get("status")

	limit := int32(50)
	offset := int32(0)

	if limitStr != "" {
		if l, err := strconv.ParseInt(limitStr, 10, 32); err == nil {
			limit = int32(l)
		}
	}

	if offsetStr != "" {
		if o, err := strconv.ParseInt(offsetStr, 10, 32); err == nil {
			offset = int32(o)
		}
	}

	// Default: show waiting games
	status := database.NullGameStatus{
		GameStatus: database.GameStatusWaiting,
		Valid:      true,
	}

	if statusStr != "" {
		status.GameStatus = database.GameStatus(statusStr)
	}

	params := database.ListGamesParams{
		HostID:    uuid.Nil, // Will match all games with OR condition
		Status:    status,
		OffsetVal: offset,
		LimitVal:  limit,
	}

	games, err := gc.queries.ListGames(ctx, params)
	if err != nil {
		log.Printf("Error listing games: %v", err)
		http.Error(w, "Error fetching games", http.StatusInternalServerError)
		return
	}

	// Get player count for each game
	type GameWithPlayers struct {
		Game        database.Game
		PlayerCount int64
	}

	gamesWithPlayers := make([]GameWithPlayers, 0, len(games))
	for _, game := range games {
		count, err := gc.queries.CountPlayersInGame(ctx, game.ID)
		if err != nil {
			log.Printf("Error counting players for game %s: %v", game.ID, err)
			count = 0
		}
		gamesWithPlayers = append(gamesWithPlayers, GameWithPlayers{
			Game:        game,
			PlayerCount: count,
		})
	}

	data := map[string]interface{}{
		"Template": "game-rooms",
		"Title":    "Game Rooms",
		"Games":    gamesWithPlayers,
		"Status":   statusStr,
	}

	gc.renderGameTemplate(w, "game-rooms", data)
}

// Show exibe detalhes de uma sala especifica (GET /games/{id})
func (gc *GameController) Show(w http.ResponseWriter, r *http.Request) {
	vars := mux.Vars(r)
	idStr := vars["id"]

	id, err := uuid.Parse(idStr)
	if err != nil {
		log.Printf("Invalid UUID format: %v", err)
		http.Error(w, "Invalid ID format", http.StatusBadRequest)
		return
	}

	ctx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
	defer cancel()

	// Get game with host information
	gameWithHost, err := gc.queries.GetGameWithHost(ctx, id)
	if err != nil {
		log.Printf("Error getting game: %v", err)
		http.Error(w, "Game not found", http.StatusNotFound)
		return
	}

	// Get players in game
	players, err := gc.queries.ListPlayersInGame(ctx, id)
	if err != nil {
		log.Printf("Error getting players: %v", err)
		players = []database.ListPlayersInGameRow{}
	}

	// Get game configuration if exists
	config, err := gc.queries.GetGameConfiguration(ctx, id)
	if err != nil {
		log.Printf("Error getting game configuration: %v", err)
		// Config might not exist, that's ok
	}

	data := map[string]interface{}{
		"Template":    "game-show",
		"Title":       "Game Details",
		"Game":        gameWithHost,
		"Players":     players,
		"Config":      config,
		"PlayerCount": len(players),
	}

	gc.renderGameTemplate(w, "game-show", data)
}

// Create exibe formulario de criacao (GET /games/new)
func (gc *GameController) Create(w http.ResponseWriter, r *http.Request) {
	data := map[string]interface{}{
		"Template": "game-create",
		"Title":    "Create New Game Room",
	}

	gc.renderGameTemplate(w, "game-create", data)
}

// Store salva nova sala de game (POST /games)
func (gc *GameController) Store(w http.ResponseWriter, r *http.Request) {
	if err := r.ParseForm(); err != nil {
		log.Printf("Error parsing form: %v", err)
		http.Error(w, "Invalid form data", http.StatusBadRequest)
		return
	}

	name := strings.TrimSpace(r.FormValue("name"))
	hostIDStr := strings.TrimSpace(r.FormValue("host_id"))
	description := strings.TrimSpace(r.FormValue("description"))
	theme := strings.TrimSpace(r.FormValue("theme"))

	// Validate input
	if validationErrors := validateGameInput(name, hostIDStr); len(validationErrors) > 0 {
		log.Printf("Validation errors: %v", validationErrors)
		data := map[string]interface{}{
			"Template": "game-create",
			"Title":    "Create New Game Room",
			"Errors":   validationErrors,
			"Name":     name,
		}
		gc.renderGameTemplate(w, "game-create", data)
		return
	}

	hostID, _ := uuid.Parse(hostIDStr)

	ctx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
	defer cancel()

	params := database.CreateGameParams{
		HostID: hostID,
		Name:   name,
		Status: database.NullGameStatus{
			GameStatus: database.GameStatusWaiting,
			Valid:      true,
		},
	}

	if description != "" {
		params.Description = &description
	}

	if theme != "" {
		params.Theme = &theme
	}

	game, err := gc.queries.CreateGame(ctx, params)
	if err != nil {
		log.Printf("Error creating game: %v", err)
		http.Error(w, "Error creating game", http.StatusInternalServerError)
		return
	}

	log.Printf("Game created successfully: %s", game.ID)
	http.Redirect(w, r, "/games", http.StatusSeeOther)
}

// Edit exibe formulario de edicao (GET /games/{id}/edit)
func (gc *GameController) Edit(w http.ResponseWriter, r *http.Request) {
	vars := mux.Vars(r)
	idStr := vars["id"]

	id, err := uuid.Parse(idStr)
	if err != nil {
		log.Printf("Invalid UUID format: %v", err)
		http.Error(w, "Invalid ID format", http.StatusBadRequest)
		return
	}

	ctx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
	defer cancel()

	game, err := gc.queries.GetGameByID(ctx, id)
	if err != nil {
		log.Printf("Error getting game: %v", err)
		http.Error(w, "Game not found", http.StatusNotFound)
		return
	}

	data := map[string]interface{}{
		"Template": "game-edit",
		"Title":    "Edit Game Room",
		"Game":     game,
	}

	gc.renderGameTemplate(w, "game-edit", data)
}

// Update atualiza sala de game (PUT/POST /games/{id})
func (gc *GameController) Update(w http.ResponseWriter, r *http.Request) {
	vars := mux.Vars(r)
	idStr := vars["id"]

	id, err := uuid.Parse(idStr)
	if err != nil {
		log.Printf("Invalid UUID format: %v", err)
		http.Error(w, "Invalid ID format", http.StatusBadRequest)
		return
	}

	if err := r.ParseForm(); err != nil {
		log.Printf("Error parsing form: %v", err)
		http.Error(w, "Invalid form data", http.StatusBadRequest)
		return
	}

	name := strings.TrimSpace(r.FormValue("name"))
	description := strings.TrimSpace(r.FormValue("description"))
	theme := strings.TrimSpace(r.FormValue("theme"))

	// Basic validation
	if len(name) < 3 {
		http.Error(w, "Game name must be at least 3 characters", http.StatusBadRequest)
		return
	}

	ctx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
	defer cancel()

	params := database.UpdateGameParams{
		ID:   id,
		Name: name,
	}

	if description != "" {
		params.Description = &description
	}

	if theme != "" {
		params.Theme = &theme
	}

	game, err := gc.queries.UpdateGame(ctx, params)
	if err != nil {
		log.Printf("Error updating game: %v", err)
		http.Error(w, "Error updating game", http.StatusInternalServerError)
		return
	}

	log.Printf("Game updated successfully: %s", game.ID)
	http.Redirect(w, r, "/games", http.StatusSeeOther)
}

// Delete remove sala de game (DELETE/POST /games/{id}/delete)
func (gc *GameController) Delete(w http.ResponseWriter, r *http.Request) {
	vars := mux.Vars(r)
	idStr := vars["id"]

	id, err := uuid.Parse(idStr)
	if err != nil {
		log.Printf("Invalid UUID format: %v", err)
		http.Error(w, "Invalid ID format", http.StatusBadRequest)
		return
	}

	ctx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
	defer cancel()

	// Hard delete
	err = gc.queries.DeleteGame(ctx, id)
	if err != nil {
		log.Printf("Error deleting game: %v", err)
		http.Error(w, "Error deleting game", http.StatusInternalServerError)
		return
	}

	log.Printf("Game deleted successfully: ID=%s", id)
	http.Redirect(w, r, "/games", http.StatusSeeOther)
}

// StartGame inicia uma sala de game (POST /games/{id}/start)
func (gc *GameController) StartGame(w http.ResponseWriter, r *http.Request) {
	vars := mux.Vars(r)
	idStr := vars["id"]

	id, err := uuid.Parse(idStr)
	if err != nil {
		log.Printf("Invalid UUID format: %v", err)
		http.Error(w, "Invalid ID format", http.StatusBadRequest)
		return
	}

	ctx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
	defer cancel()

	game, err := gc.queries.StartGame(ctx, id)
	if err != nil {
		log.Printf("Error starting game: %v", err)
		http.Error(w, "Error starting game", http.StatusInternalServerError)
		return
	}

	log.Printf("Game started successfully: %s", game.ID)
	http.Redirect(w, r, "/games/"+id.String(), http.StatusSeeOther)
}

// FinishGame finaliza uma sala de game (POST /games/{id}/finish)
func (gc *GameController) FinishGame(w http.ResponseWriter, r *http.Request) {
	vars := mux.Vars(r)
	idStr := vars["id"]

	id, err := uuid.Parse(idStr)
	if err != nil {
		log.Printf("Invalid UUID format: %v", err)
		http.Error(w, "Invalid ID format", http.StatusBadRequest)
		return
	}

	ctx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
	defer cancel()

	game, err := gc.queries.FinishGame(ctx, id)
	if err != nil {
		log.Printf("Error finishing game: %v", err)
		http.Error(w, "Error finishing game", http.StatusInternalServerError)
		return
	}

	log.Printf("Game finished successfully: %s", game.ID)
	http.Redirect(w, r, "/games/"+id.String(), http.StatusSeeOther)
}
