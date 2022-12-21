.PHONY: __usage__ all clean cf-uaac ruby-release
MAKEFLAGS += --jobs --no-print-directory

# fetch informations about the latest release
latest_release_github = wget -qO- "https://api.github.com/repos/${1}/releases/latest"
# ensure the release is production grade
latest_release_jq := jq -re '.|select(.draft==false)|select(.prerelease==false).tag_name|ltrimstr("v")'

CF_VERSION := latest
PXC_VERSION := TODO
RUBY_VERSION := latest
UAAC_VERSION := latest

__usage__:
	@>&2 echo "try: $(MAKE) help"
	@exit 64

all: cf-cli cf-uaac pxc ruby-release
	@$(info all done)

cf-cli:
	@CF_VERSION=${CF_VERSION};\
	[ -z "$${CF_VERSION%latest}" ] &&\
	CF_VERSION=$(shell $(call latest_release_github,cloudfoundry/cli) | $(latest_release_jq));\
	$(MAKE) cf-cli-$${CF_VERSION} &&\
	ln -fsv "cf-cli-$${CF_VERSION}" "$@"

cf-cli-%:
	@wget -c -O "$@" "https://packages.cloudfoundry.org/stable?release=linux64-binary&version=${*}&source=github-rel"
	@chmod -c 0755 "$@"


pxc:  # TODO
	$(info no-op)
#	@PXC_VERSION=${PXC_VERSION};\
#	[ -z "$${PXC_VERSION%latest}" ] &&\
#	PXC_VERSION=$(shell $(call latest_release_github,cloudfoundry/pxc-release) | $(latest_release_jq));\
#	echo PXC_VERSION=$${PXC_VERSION}


cf-uaac/.git:
ruby-release/.git:
	@git submodule update --init $(@:/.git=)


ruby-release: ruby-release/.git
	@export GIT_DIR=$@/.git RUBY_VERSION=${RUBY_VERSION};\
	if [ -z "$${RUBY_VERSION%latest}" ];\
	then\
		git fetch --tags;\
		export RUBY_VERSION=$$(git describe --tags --abbrev=0 origin/master);\
	fi;\
	git checkout --force "refs/tags/$${RUBY_VERSION:?}";\
	echo $@-$${RUBY_VERSION}


cf-uaac: cf-uaac/.git
	@export GIT_DIR=$@/.git UAAC_VERSION=${UAAC_VERSION};\
	if [ -z "$${UAAC_VERSION%latest}" ];\
	then\
		git fetch;\
		export UAAC_VERSION=$$(git describe --tags --abbrev=0 origin/main);\
	fi;\
	git checkout --force "refs/tags/$${UAAC_VERSION:?}";\
	echo uaac-$${UAAC_VERSION}


clean:
	rm -vf cf-cli*

# Must be last
help:
	$(info List of available targets:)
	@$(MAKE) -npr | \
		awk -F: '\
		/^[a-zA-Z0-9][^$$#\/\t%=]*:([^=]|$$)/{ \
		split($$1,A,/ /);for(i in A)print A[i] \
	}' | sed '/^[Mm]ake/d;s/^/\t/' \
	| sort -n
