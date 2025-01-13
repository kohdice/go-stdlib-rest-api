package interfaces

import (
	"database/sql"
	"fmt"
	"net/http"

	"github.com/kohdice/go-stdlib-rest-api/internal/application"
)

type handler struct {
	Service application.ApplicationServicer
}

func (h *handler) PokemonHandler(w http.ResponseWriter, r *http.Request) {
	switch r.Method {
	case http.MethodGet:
		g := h.Service.GetPokemon()
		fmt.Fprintln(w, g)
	default:
		http.Error(w, "Method not allowed", http.StatusMethodNotAllowed)
	}
}

func NewHandler(db *sql.DB) *handler {
	return &handler{Service: application.NewService(db)}
}
