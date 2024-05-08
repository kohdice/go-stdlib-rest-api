package main

import (
	"fmt"
	"log"
	"net/http"
)

func main() {
	server := http.Server{
		Addr:    ":8080",
		Handler: nil,
	}

	http.HandleFunc("/", requestHandler)

	log.Println("Starting server")
	server.ListenAndServe()
}

func requestHandler(w http.ResponseWriter, r *http.Request) {
	switch r.Method {
	case "GET":
		fmt.Fprintln(w, "GET")
	case "POST":
		fmt.Fprintln(w, "POST")
	case "PUT":
		fmt.Fprintln(w, "PUT")
	case "DELETE":
		fmt.Fprintln(w, "DELETE")
	}
}
