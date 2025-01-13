package application

import (
	"database/sql"

	"github.com/kohdice/go-stdlib-rest-api/internal/infrastructure"
)

type ApplicationServicer interface {
	GetPokemon() string
}

type ApplicationService struct {
	repository infrastructure.IFRepository
}

func (s *ApplicationService) GetPokemon() string {
	return "Pikachu !"
}

func NewService(db *sql.DB) *ApplicationService {
	return &ApplicationService{infrastructure.NewRepository(db)}
}
