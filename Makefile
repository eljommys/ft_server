.PHONY: build run

build:
	docker build -t jserrano .

run:
	docker run -it -p 80:80 -p 443:443 jserrano
