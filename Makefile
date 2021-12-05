run:
	@docker-compose up
stop:
	@docker-compose down --remove-orphans
litestream:
	# Data directory for litestream backup created if not existing
	@mkdir -p data/litestream && docker-compose -f docker-compose-litestream.yaml up
restore:
	@docker-compose -f docker-compose-litestream.yaml --profile litestream up litestream
primary:
	@rm db && ln -s db-primary db
secondary:
	@rm db && ln -s db-secondary db
clean:
	@rm -rf ./db/data* && rm -rf ./db/.data.db-litestream/ 
