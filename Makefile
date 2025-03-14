include .env
export

DBT_FOLDER = transform/pypi_metrics/
DBT_TARGET = dev

.PHONY : help pypi-transform 

pypi-transform:
	cd $$DBT_FOLDER && \
	poetry run dbt run \
		--target $$DBT_TARGET \
		--vars '{"start_date": "$(START_DATE)", "end_date": "$(END_DATE)"}'

pypi-transform-test:
	cd $$DBT_FOLDER && \
	poetry run dbt test \
		--vars '{"start_date": "2023-04-01", "end_date": "2023-04-07"}'


dbt-deps:
	cd $$DBT_FOLDER && \
	poetry run dbt deps