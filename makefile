.PHONY := dev build

.DEFAULT_GOAL := dev

##################################  build final packeges #################################

build:
	pnpm --dir ./packages/library run build


##################################  dev #################################
NUM_CORES := $(shell nproc)
NUM_JOBS := $(shell expr $(NUM_CORES) / 2)

dev:
	make -j$(NUM_JOBS) templ air devlib

check_air_installed:
	@command -v air >/dev/null 2>&1 || { echo "Installing air..."; go install github.com/air-verse/air@latest; }


check_templ_installed:
	@command -v templ >/dev/null 2>&1 || { echo "Installing air..."; go install github.com/a-h/templ/cmd/templ@latest; }	

templ: check_templ_installed
	templ generate -path test/go/view -watch

air: check_air_installed
	air

devlib:
	pnpm --dir ./packages/library run dev