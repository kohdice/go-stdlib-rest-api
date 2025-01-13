package main

import (
	"log"
	"net/http"

	"github.com/kohdice/go-stdlib-rest-api/internal/infrastructure"
	"github.com/kohdice/go-stdlib-rest-api/internal/interfaces"
	_ "github.com/lib/pq"
)

func main() {
	db, err := infrastructure.NewDB()
	if err != nil {
		log.Fatalf("Failed to connect to database: %v", err)
	}

	handler := interfaces.NewHandler(db)

	server := http.Server{
		Addr:    ":8080",
		Handler: nil,
	}

	http.HandleFunc("/", handler.PokemonHandler)

	log.Println("Starting server")
	server.ListenAndServe()
}
