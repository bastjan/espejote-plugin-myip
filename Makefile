.PHONY: build
build: plugin.wasm plugin.wasm.br
	@ls -lh plugin.wasm plugin.wasm.br

.PHONY: run
run: plugin.wasm
	go tool github.com/stealthrocket/wasi-go/cmd/wasirun --dir=/ plugin.wasm

release: plugin.wasm
	# Requires `oras` to be installed: https://oras.land/docs/install/
	# Requires `ghcr.io` to be logged in: `oras login ghcr.io`
	## Create personal access token with `write:packages` scope
	oras push ghcr.io/bastjan/espejote-plugin-myip:latest plugin.wasm:application/vnd.module.wasm.content.layer.v1+wasm

plugin.wasm: *.go
	GOOS=wasip1 GOARCH=wasm go build -o plugin.wasm .

plugin.wasm.br: plugin.wasm
	brotli -f plugin.wasm
