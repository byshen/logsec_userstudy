cnf ?= .env
include  $(cnf)
export $(shell sed 's/=.*//' $(cnf))

default: 
	@echo 'choose a target'

# build_base:
# 	sudo docker build --tag operaimg/ubuntu_base:1.2 ../base

build: 
	sudo docker-compose build

run: 
	@test -s ${htdocs} || { echo "${htdocs} does not exist"; exit 1; }
	@test -s ${etc} || { echo "${etc} does not exist"; exit 1; }
	sudo docker-compose up

clean:
	sudo docker-compose down
.PHONY: all test clean run
