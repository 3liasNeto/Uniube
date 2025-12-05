package controllers

import (
	"context"
	"html/template"
	"log"
	"net/http"
	"strings"
	"time"

	database "trabalhon-n2/db"
	"trabalhon-n2/helpers"

	"github.com/google/uuid"
	"github.com/gorilla/mux"
	"golang.org/x/crypto/bcrypt"
)

type UserController struct {
	queries   *database.Queries
	templates *template.Template
}

// NewUserController inicializa o controller com queries e templates pre-carregados
func NewUserController() *UserController {
	// Parse templates uma vez na inicializacao para melhor performance
	tmpl := template.Must(template.ParseGlob("views/**/*.html"))

	return &UserController{
		queries:   database.New(helpers.DB),
		templates: tmpl,
	}
}

// hashPassword gera um hash bcrypt para a senha
func hashPassword(password string) (string, error) {
	bytes, err := bcrypt.GenerateFromPassword([]byte(password), bcrypt.DefaultCost)
	return string(bytes), err
}

// validateUserInput valida os dados do usuario
func validateUserInput(username, email, password string) []string {
	var errors []string

	if len(strings.TrimSpace(username)) < 3 {
		errors = append(errors, "Username must be at least 3 characters")
	}

	if !strings.Contains(email, "@") || !strings.Contains(email, ".") {
		errors = append(errors, "Invalid email format")
	}

	if len(password) < 6 {
		errors = append(errors, "Password must be at least 6 characters")
	}

	return errors
}

// renderTemplate renderiza um template com tratamento de erro
func (uc *UserController) renderTemplate(w http.ResponseWriter, name string, data interface{}) {
	if err := uc.templates.ExecuteTemplate(w, name, data); err != nil {
		log.Printf("Error rendering template %s: %v", name, err)
		http.Error(w, "Internal Server Error", http.StatusInternalServerError)
	}
}

// Index lista todos os usuarios (GET /users)
func (uc *UserController) Index(w http.ResponseWriter, r *http.Request) {
	ctx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
	defer cancel()

	params := database.ListUsersParams{
		OffsetVal: 0,
		LimitVal:  100, // Limite de 100 usuarios por pagina
	}

	users, err := uc.queries.ListUsers(ctx, params)
	if err != nil {
		log.Printf("Error listing users: %v", err)
		http.Error(w, "Error fetching users", http.StatusInternalServerError)
		return
	}

	data := map[string]interface{}{
		"Title":    "User List",
		"Users":    users,
		"Template": "user-index",
	}

	uc.renderTemplate(w, "base", data)
}

// Show exibe um usuario especifico (GET /users/{id})
func (uc *UserController) Show(w http.ResponseWriter, r *http.Request) {
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

	user, err := uc.queries.GetUserByID(ctx, id)
	if err != nil {
		log.Printf("Error getting user: %v", err)
		http.Error(w, "User not found", http.StatusNotFound)
		return
	}

	data := map[string]interface{}{
		"Title":    "User Details",
		"User":     user,
		"Template": "user-show",
	}

	uc.renderTemplate(w, "base", data)
}

// Create exibe formulario de criacao (GET /users/new)
func (uc *UserController) Create(w http.ResponseWriter, r *http.Request) {
	data := map[string]interface{}{
		"Title":    "New User",
		"Template": "user-create",
	}

	uc.renderTemplate(w, "base", data)
}

// Store salva novo usuario (POST /users)
func (uc *UserController) Store(w http.ResponseWriter, r *http.Request) {
	if err := r.ParseForm(); err != nil {
		log.Printf("Error parsing form: %v", err)
		http.Error(w, "Invalid form data", http.StatusBadRequest)
		return
	}

	username := strings.TrimSpace(r.FormValue("username"))
	email := strings.TrimSpace(r.FormValue("email"))
	password := r.FormValue("password")

	// Validate input
	if validationErrors := validateUserInput(username, email, password); len(validationErrors) > 0 {
		log.Printf("Validation errors: %v", validationErrors)
		data := map[string]interface{}{
			"Title":     "New User",
			"Errors":    validationErrors,
			"Username":  username,
			"Email":     email,
			"FirstName": strings.TrimSpace(r.FormValue("first_name")),
			"LastName":  strings.TrimSpace(r.FormValue("last_name")),
			"Template":  "user-create",
		}
		uc.renderTemplate(w, "base", data)
		return
	}

	// Hash password
	hashedPassword, err := hashPassword(password)
	if err != nil {
		log.Printf("Error hashing password: %v", err)
		http.Error(w, "Internal Server Error", http.StatusInternalServerError)
		return
	}

	ctx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
	defer cancel()

	params := database.CreateUserParams{
		Username:  username,
		FirstName: strings.TrimSpace(r.FormValue("first_name")),
		LastName:  strings.TrimSpace(r.FormValue("last_name")),
		Email:     email,
		Password:  hashedPassword,
	}

	user, err := uc.queries.CreateUser(ctx, params)
	if err != nil {
		log.Printf("Error creating user: %v", err)
		http.Error(w, "Error creating user", http.StatusInternalServerError)
		return
	}

	log.Printf("User created successfully: %s", user.ID)
	http.Redirect(w, r, "/users", http.StatusSeeOther)
}

// Edit exibe formulario de edicao (GET /users/{id}/edit)
func (uc *UserController) Edit(w http.ResponseWriter, r *http.Request) {
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

	user, err := uc.queries.GetUserByID(ctx, id)
	if err != nil {
		log.Printf("Error getting user: %v", err)
		http.Error(w, "User not found", http.StatusNotFound)
		return
	}

	data := map[string]interface{}{
		"Title":    "Edit User",
		"User":     user,
		"Template": "user-edit",
	}

	uc.renderTemplate(w, "base", data)
}

// Update atualiza usuario (PUT/POST /users/{id})
func (uc *UserController) Update(w http.ResponseWriter, r *http.Request) {
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

	username := strings.TrimSpace(r.FormValue("username"))
	email := strings.TrimSpace(r.FormValue("email"))

	// Basic validation
	if len(username) < 3 {
		http.Error(w, "Username must be at least 3 characters", http.StatusBadRequest)
		return
	}

	if !strings.Contains(email, "@") {
		http.Error(w, "Invalid email format", http.StatusBadRequest)
		return
	}

	ctx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
	defer cancel()

	params := database.UpdateUserParams{
		ID:        id,
		Username:  username,
		FirstName: strings.TrimSpace(r.FormValue("first_name")),
		LastName:  strings.TrimSpace(r.FormValue("last_name")),
		Email:     email,
	}

	user, err := uc.queries.UpdateUser(ctx, params)
	if err != nil {
		log.Printf("Error updating user: %v", err)
		http.Error(w, "Error updating user", http.StatusInternalServerError)
		return
	}

	log.Printf("User updated successfully: %s", user.ID)
	http.Redirect(w, r, "/users", http.StatusSeeOther)
}

// Delete remove usuario (DELETE/POST /users/{id}/delete)
func (uc *UserController) Delete(w http.ResponseWriter, r *http.Request) {
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

	// Soft delete - updates deleted_at
	err = uc.queries.SoftDeleteUser(ctx, id)
	if err != nil {
		log.Printf("Error deleting user: %v", err)
		http.Error(w, "Error deleting user", http.StatusInternalServerError)
		return
	}

	log.Printf("User soft deleted successfully: ID=%s", id)
	http.Redirect(w, r, "/users", http.StatusSeeOther)
}