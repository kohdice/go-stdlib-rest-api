package infrastructure

import "database/sql"

type IFRepository interface {
	GetPokemon() string
}

type Repository struct {
	db *sql.DB
}

func (r *Repository) GetPokemon() string {
	return "Pikachu !"
}

func NewRepository(db *sql.DB) *Repository {
	return &Repository{db: db}
}
