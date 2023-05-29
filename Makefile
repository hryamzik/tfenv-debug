clean:
	@find . -type d -name ".terragrunt-cache" -prune -exec rm -rvf {} \;
	@find . -name ".terraform.lock.hcl" -prune -exec rm -rvf {} \;
build:
	docker-compose build
up:
	docker-compose up -d
down:
	docker-compose rm -sf
bash-tfenv:
	docker exec -ti tf-env-126-tfenv-1 /bin/bash
bash-tf:
	docker exec -ti tf-env-126-terraform-1 /bin/bash
bash-tooling:
	docker run --rm -ti -v $$PWD/code:/code -w /code/terragrunt terraform-tooling:arm /bin/bash
tfenv:
	docker exec -ti tf-env-126-tfenv-1 terragrunt run-all validate
tf:
	docker exec -ti tf-env-126-terraform-1 terragrunt run-all validate
tooling:
	docker run --rm -ti -v $$PWD/code:/code -w /code/terragrunt terraform-tooling:arm terragrunt run-all validate
local:
	cd code/terragrunt && terragrunt run-all validate

.PHONY: tfenv
