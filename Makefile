all: clean build deploy

build:
	./bin/build.sh

deploy:
	./bin/deploy.sh

clean:
	@rm -rf ./public

