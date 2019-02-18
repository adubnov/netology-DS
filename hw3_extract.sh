#!/usr/bin/env bash
NETOLOGY_DATA=/usr/local/share/netology
APP_POSTGRES_HOST=localhost

# Drop the keywords table if exists.
psql -U postgres -c "DROP TABLE IF EXISTS keywords"

# Create the keywords table with 2 rows: id(bigint) and tags(text)
psql -U postgres -c '
  CREATE TABLE keywords (
    id  bigint,
    tags text
  );'

# Export data from keywords.csv file into the keywords table
psql -U postgres -c \
    "\\copy keywords FROM '$NETOLOGY_DATA/raw_data/keywords.csv' DELIMITER ',' CSV HEADER"

# Check the result
psql -U postgres -c "SELECT  COUNT(*) FROM keywords"

