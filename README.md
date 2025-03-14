# Transformations with dbt + DuckDB

This project focuses on the transformation layer of the data pipeline and unit testing using `dbt` and `DuckDB`.  
It demonstrates how to process raw PyPI download data stored in AWS S3, apply transformations, and write the outputs back to S3.  
Unit testing is integrated using `dbt_unit_testing` to validate transformations and ensure data quality.

The example transformations aggregate download statistics and normalize PyPI file download records. The setup leverages DuckDB, with dbt handling the transformation logic and testing.

---

### Installation
I use Poetry for dependency management. To install dbt and the appropriate DuckDB adapter, run:

```
poetry add dbt-duckdb[md]
```

Then, initialize your dbt project (under ./transform) with:

```
dbt init pypi_metrics
```

## Setup

Fill out the `.env` file with the following variables.  
You can use the `TRANSFORM_S3_PATH_INPUT` provided below, which points to a public S3 bucket containing sample data:

```
TRANSFORM_S3_PATH_INPUT=s3://us-prd-motherduck-open-datasets/pypi/sample_tutorial/pypi_file_downloads///*.parquet
TRANSFORM_S3_PATH_OUTPUT=s3://my-output-bucket/
```

Run a transformation that reads from S3 and writes back to S3:
```
make pypi-transform START_DATE=2023-04-05 END_DATE=2023-04-07 DBT_TARGET=dev
```
Run unit tests on your transformations:

```
make pypi-transform-test
```

