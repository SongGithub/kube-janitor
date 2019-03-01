.PHONY: test docker push

IMAGE            ?= hjacobs/kube-janitor
VERSION          ?= $(shell git describe --tags --always --dirty)
TAG              ?= $(VERSION)
BUILD_IMAGE      ?= janitor_build:latest

default: docker


build:
	docker build . -f Dockerfile -t $(BUILD_IMAGE)

test: build
	docker run -w /app -v $(PWD):/app --rm $(BUILD_IMAGE) sh -c " \
		pipenv run flake8 && \
		pipenv run coverage run --source=kube_janitor -m py.test && \
		pipenv run coverage report"

docker: build
	docker build -f DockerfileII --build-arg "BUILD_IMAGE=$(BUILD_IMAGE)" --build-arg "VERSION=$(VERSION)" -t "$(IMAGE):$(TAG)" .
	@echo 'Docker image $(IMAGE):$(TAG) can now be used.'

push: docker
	docker push "$(IMAGE):$(TAG)"
