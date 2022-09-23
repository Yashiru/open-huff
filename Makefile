ifneq (,$(wildcard ./.env))
	include .env
endif

generate-interfaces: 
	./generateInterfaces.sh