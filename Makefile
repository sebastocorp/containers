PROJECT ?= 
VERSION ?= 

CONTAINER_TOOL ?= docker
REGISTRY ?= ghcr.io/sebastocorp

IMG_BUILD_EXTRA ?=
IMG_TAG_EXTRA ?=
IMG_NAME ?= containers
IMG_TAG ?= $(PROJECT)-v$(VERSION)$(IMG_TAG_EXTRA)
IMG ?= $(REGISTRY)/$(IMG_NAME):$(IMG_TAG)

ifeq ($(strip $(PROJECT)),)
$(error you must set the variable 'PROJECT' to execute this makefile)
endif

ifeq ($(strip $(VERSION)),)
$(error you must set the variable 'VERSION' to execute this makefile)
endif

VERSION_REGEX='^[0-9]+\.[0-9]+\.[0-9]+$$'

ifeq ($(shell echo $(VERSION) | grep -Eq $(VERSION_REGEX) && echo OK),)
$(error variable 'VERSION' must be in semver format 'x.y.z', e.g. '1.2.3')
endif

.PHONY: build
all: push

.PHONY: build
build:
	$(CONTAINER_TOOL) build --file $(PROJECT)/Containerfile --build-arg VERSION=$(VERSION) --build-arg CONFIGURE_FLAGS=$(IMG_BUILD_EXTRA) --no-cache --tag '$(IMG)' $(PROJECT)

.PHONY: push
push: build
	$(CONTAINER_TOOL) push $(IMG)

.PHONY: print
print:
	@echo "$(CONTAINER_TOOL) build --file $(PROJECT)/Containerfile --build-arg VERSION=$(VERSION) --build-arg CONFIGURE_FLAGS=$(IMG_BUILD_EXTRA) --no-cache --tag '$(IMG)' $(PROJECT)"
