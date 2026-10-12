TF ?= terraform
ROOTS := infra/bootstrap infra/envs/dev

.PHONY: fmt check validate lint
fmt:
	$(TF) fmt -recursive infra

check:
	$(TF) fmt -recursive -check -diff infra

validate:
	@for d in $(ROOTS); do \
	  echo "== validate $$d"; \
	  $(TF) -chdir=$$d init -backend=false -input=false >/dev/null && \
	  $(TF) -chdir=$$d validate || exit 1; \
	done

lint:
	tflint --init && tflint --recursive
