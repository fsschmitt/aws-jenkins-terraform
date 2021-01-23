DOCKERHUB_USERNAME?=fsschmitt
IMAGE_TAG?=$(DOCKERHUB_USERNAME)/cloud-sdk-container

run:
	docker run --env-file=.env --rm -it -v $$(pwd):/root/src $(IMAGE_TAG):latest bash
