package routes

import (
	"log"
	"net/http"
	"time"

	"trabalhon-n2/controllers"

	"github.com/gorilla/mux"
)

func loggingMiddleware(next http.Handler) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		start := time.Now()

		log.Printf("Started %s %s", r.Method, r.URL.Path)

		next.ServeHTTP(w, r)

		log.Printf("Completed %s %s in %v", r.Method, r.URL.Path, time.Since(start))
	})
}

func recoveryMiddleware(next http.Handler) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		defer func() {
			if err := recover(); err != nil {
				log.Printf("Panic recovered: %v", err)
				http.Error(w, "Internal Server Error", http.StatusInternalServerError)
			}
		}()
		next.ServeHTTP(w, r)
	})
}

func corsMiddleware(next http.Handler) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		w.Header().Set("Access-Control-Allow-Origin", "*")
		w.Header().Set("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, OPTIONS")
		w.Header().Set("Access-Control-Allow-Headers", "Content-Type, Authorization")

		if r.Method == "OPTIONS" {
			w.WriteHeader(http.StatusOK)
			return
		}

		next.ServeHTTP(w, r)
	})
}

func SetupRoutes() *mux.Router {
	r := mux.NewRouter()

	r.Use(recoveryMiddleware)
	r.Use(loggingMiddleware)
	r.Use(corsMiddleware)

	r.PathPrefix("/static/").Handler(
		http.StripPrefix("/static/", http.FileServer(http.Dir("static"))),
	)

	// Controllers
	userController := controllers.NewUserController()
	// gameController := controllers.NewGameController()

	// Rota raiz redireciona para /games
	r.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		http.Redirect(w, r, "/users", http.StatusSeeOther)
	}).Methods("GET")

	// Rotas de usuários
	r.HandleFunc("/users", userController.Index).Methods("GET")
	r.HandleFunc("/users/new", userController.Create).Methods("GET")
	r.HandleFunc("/users", userController.Store).Methods("POST")
	r.HandleFunc("/users/{id}", userController.Show).Methods("GET")
	r.HandleFunc("/users/{id}/edit", userController.Edit).Methods("GET")
	r.HandleFunc("/users/{id}", userController.Update).Methods("POST")
	r.HandleFunc("/users/{id}/delete", userController.Delete).Methods("POST")

	// Rotas de games
	// r.HandleFunc("/games", gameController.Index).Methods("GET")
	// r.HandleFunc("/games/new", gameController.Create).Methods("GET")
	// r.HandleFunc("/games", gameController.Store).Methods("POST")
	// r.HandleFunc("/games/{id}", gameController.Show).Methods("GET")
	// r.HandleFunc("/games/{id}/edit", gameController.Edit).Methods("GET")
	// r.HandleFunc("/games/{id}", gameController.Update).Methods("POST")
	// r.HandleFunc("/games/{id}/delete", gameController.Delete).Methods("POST")
	// r.HandleFunc("/games/{id}/start", gameController.StartGame).Methods("POST")
	// r.HandleFunc("/games/{id}/finish", gameController.FinishGame).Methods("POST")

	return r
}
