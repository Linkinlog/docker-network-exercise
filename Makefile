option1:
	@docker compose -f ./docker-compose-option1.yml down --remove-orphans
	@docker compose -f ./docker-compose-option1.yml up --build
option2:
	@docker compose -f ./docker-compose-option2.yml down --remove-orphans
	@docker compose -f ./docker-compose-option2.yml up --build
option3:
	@docker compose -f ./docker-compose-option3.yml down --remove-orphans
	@docker compose -f ./docker-compose-option3.yml up --build
option4:
	@docker compose -f ./docker-compose-option4.yml down --remove-orphans
	@docker compose -f ./docker-compose-option4.yml up --build
option5:
	@docker compose -f ./docker-compose-option5.yml down --remove-orphans
	@docker compose -f ./docker-compose-option5.yml up --build
option5_1:
	@docker compose -f ./docker-compose-option5_1.yml down --remove-orphans
	@docker compose -f ./docker-compose-option5_1.yml up --build

.PHONY: option1 option2 option3 option4 option5 option5_1
