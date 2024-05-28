VSCODE_REPO=nicholasjackson/spring-vault-vscode
VSCODE_VERSION=v0.0.2

APP_REPO=nicholasjackson/spring-vault-example
APP_VERSION=v0.0.3

build_and_push_app:
	./gradlew clean build

	docker run --rm --privileged multiarch/qemu-user-static --reset -p yes
	docker buildx create --name vscode || true
	docker buildx use vscode
	docker buildx inspect --bootstrap
	docker buildx build --platform linux/arm64,linux/amd64 \
		-t ${APP_REPO}:${APP_VERSION} \
		-f ./Dockerfiles/app/Dockerfile \
		. \
		--push
	docker buildx rm -f vscode

build_and_push_vscode:
	docker run --rm --privileged multiarch/qemu-user-static --reset -p yes
	docker buildx create --name vscode || true
	docker buildx use vscode
	docker buildx inspect --bootstrap
	docker buildx build --platform linux/arm64,linux/amd64 \
		-t ${VSCODE_REPO}:${VSCODE_VERSION} \
		-f ./Dockerfiles/vscode/Dockerfile \
		. \
		--push
	docker buildx rm -f vscode

build_instruqt_vm:
	cd ./jumppad/packer && packer build -var-file ./main.pkrvars.hcl ./main.pkr.hcl