ifneq (,$(wildcard ./.env))
	include .env
endif

interfaces: 
	./generateInterfaces.sh