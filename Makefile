run:
	@docker-compose up
stop:
	@docker-compose down
litestream:
	# Data directory for litestream backup created if not existing
	@mkdir -p data/litestream && docker-compose -f docker-compose-litestream.yaml up

