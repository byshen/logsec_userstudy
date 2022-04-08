#!/bin/bash


# mount_overlay source overlay target
mount_overlay () {
    sudo mkdir -p $2 && \
    sudo mount -t tmpfs tmpfs $2 && \
    sudo mkdir -p $2/{upper,work} && \
    sudo mount -t overlay overlay -o lowerdir=$1,upperdir=$2/upper,workdir=$2/work $3
}

# compile
cd "/install/eval_postgres"

prefix=/pgdatabase/data/

if [ ! -f "GNUmakefile" ]; then
./configure --prefix=/opt/PostgreSQL
fi


# https://www.tecmint.com/install-postgresql-from-source-code-in-linux/


# always run make && make install
make -j8

TYPE="enhancelog"


# THIS is the version with enhanced logs
if [[ $TYPE = "enhancelog" ]]; then
    sudo cp /install/eval_postgres/postgres-enhancelog /install/eval_postgres/src/backend/postgres
fi


sudo make install
# export PATH=$PATH:/opt/PostgreSQL/bin
# sudo ln /opt/PostgreSQL/bin/* /usr/local/bin/

# mount htdocs and conf in the container
USER="postgres"
sudo rm -rf /pgdatabase/data
sudo mkdir -p /pgdatabase/data
sudo chown -R postgres. /pgdatabase/data

initdb -D /pgdatabase/data/ -U postgres

# hack here - use zsh zpty function to echo password in creating db
# zsh
# export "PATH=$PATH:/usr/local/pgsql/bin"
# zmodload zsh/zpty
# zpty initpsqldb "initdb -D /pgdatabase/data/ -U postgres -W"
# zpty -r initpsqldb nl "*superuser password:"
# zpty -w initpsqldb "dummypw^M"
# zpty -r initpsqldb nl "*Enter it again"
# zpty -w initpsqldb "dummypw^M"
# zpty -d initpsqldb


# mount_overlay /tmp/htdocs /tmp/overlay_htdocs /var/www/html
# sudo cp /tmp/conf/*.conf ${prefix}
echo "config done"

export PATH=$PATH:/opt/PostgreSQL/bin
pg_ctl -D /pgdatabase/data/ -l /pgdatabase/data/start.log start


psql -f /install/postgres/experiment.sql
# keep the container running, so we can attach to it
echo "run 'sudo docker exec -it postgres_postgres_1 bash' to obtain a shell into the container"
echo "run psql -p 5432 to connect to it"
echo "psql -f /tmp/sql/xxxx.sql to run the query"

tail -f /dev/null
#/bin/bash
