package main

import (
	"io"
	"net/http"
	"os"

	_ "github.com/stealthrocket/net/http"
	_ "github.com/stealthrocket/net/wasip1"
)

func main() {
	req, err := http.NewRequest("GET", "https://ip.me", nil)
	if err != nil {
		panic(err)
	}
	req.Header.Set("User-Agent", "curl/8.7.1")
	req.Header.Set("Accept", "text/plain")

	res, err := http.DefaultClient.Do(req)
	if err != nil {
		panic(err)
	}
	defer res.Body.Close()
	if res.StatusCode != http.StatusOK {
		panic("unexpected status code: " + res.Status)
	}
	io.Copy(os.Stdout, res.Body)
}
