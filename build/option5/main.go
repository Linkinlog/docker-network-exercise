package main

import (
	"fmt"
	"net/http"
)

func main() {
	router := http.NewServeMux()

	counter := 0
	router.HandleFunc("GET /", func(w http.ResponseWriter, r *http.Request) {
		w.Write([]byte(fmt.Sprintf("Hello, World! Counter: %d", counter)))
		counter += 1
	})

	if err := http.ListenAndServe(":80", router); err != nil {
		panic(err)
	}
}
