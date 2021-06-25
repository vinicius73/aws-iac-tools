DOCKER_HUB_REPO=vinicius73/aws-iac-tools

define buildDocker
	docker build -t ${DOCKER_HUB_REPO}:$(shell cat .version) .
endef

build:
	- @cp Dockerfile.template Dockerfile
	- @echo "What is the terraform version?"; \
		read TERRAFORM_VER; \
		sed -i "s#<TERRAFORM_VER>#$$TERRAFORM_VER#g" Dockerfile;
	- @echo "What is the aws-cli version?"; \
		read AWS_CLI_VERSION; \
		sed -i "s#<AWS_CLI_VERSION>#$$AWS_CLI_VERSION#g" Dockerfile;
	- @echo "What is the tag?"; \
		read VERSION; \
		echo $$VERSION > .version;
	- $(call buildDocker)