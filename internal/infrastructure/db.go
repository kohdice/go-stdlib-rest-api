package infrastructure

import (
	"database/sql"
	"fmt"
	"os"
)

func NewDB() (*sql.DB, error) {
	databaseURL, ok := os.LookupEnv("DATABASE_URL")
	if !ok {
		return nil, fmt.Errorf("DATABASE_URL is not set")
	}

	db, err := sql.Open("postgres", databaseURL)
	if err != nil {
		return nil, err
	}

	return db, nil
}
