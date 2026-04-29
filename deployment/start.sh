#!/bin/bash

# Parse DATABASE_URL if present
if [ ! -z "$DATABASE_URL" ]; then
  # Expected format: postgres://user:password@host:port/dbname
  export DB_USER=$(echo $DATABASE_URL | sed -e 's/.*:\/\/\([^:]*\):.*/\1/')
  export DB_PASSWORD=$(echo $DATABASE_URL | sed -e 's/.*:\/\/[^:]*:\([^@]*\)@.*/\1/')
  export DB_HOST=$(echo $DATABASE_URL | sed -e 's/.*@\([^:]*\):.*/\1/')
  export DB_PORT=$(echo $DATABASE_URL | sed -e 's/.*@.*:\([^\/]*\)\/.*/\1/')
  export DB_NAME=$(echo $DATABASE_URL | sed -e 's/.*\/\([^\?]*\).*/\1/')
fi

# Run Odoo
exec python3 odoo-bin \
    --http-port=$PORT \
    --db_host=$DB_HOST \
    --db_port=$DB_PORT \
    --db_user=$DB_USER \
    --db_password=$DB_PASSWORD \
    --database=$DB_NAME \
    --proxy-mode \
    --data-dir=/var/lib/odoo
