all: clean build deploy

HUGO_THEME?= octopress

build:
	./bin/build.sh

deploy:
	./bin/deploy.sh

clean:
	@rm -rf ./public

serve:
	@hugo server --buildDrafts --theme=$(HUGO_THEME) -v
