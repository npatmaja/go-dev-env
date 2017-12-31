build:
	docker build -t npatmaja/godev .

build/tag:
	docker build -t npatmaja/godev:$(tag) .
