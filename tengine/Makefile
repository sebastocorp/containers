VERSION ?= 3.1.0

docker-build:
	docker build --file Containerfile --build-arg VERSION=${VERSION} --tag 'tengine:v${VERSION}' .