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
	sudo docker-compose up

clean:
	sudo docker-compose down
	
.PHONY: all test clean run
