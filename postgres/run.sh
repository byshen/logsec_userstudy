#!/bin/bash


# mount_overlay source overlay target
mount_overlay () {
    sudo mkdir -p $2 && \
    sudo mount -t tmpfs tmpfs $2 && \
    sudo mkdir -p $2/{upper,work} && \
    sudo mount -t overlay overlay -o lowerdir=$1,upperdir=$2/upper,workdir=$2/work $3
}

# compile
cd "/docker_code/app/postgresql-12.7"

prefix=/pgdatabase/data/

if [ ! -f "Makefile" ]; then
./configure 
fi

# always run make && make install
make -j8
sudo make install
# export PATH=$PATH:/usr/local/pgsql/bin
sudo ln /usr/local/pgsql/bin/* /usr/local/bin/

# mount htdocs and conf in the container
USER="postgres"
sudo rm -rf /pgdatabase/data
sudo mkdir -p /pgdatabase/data
sudo chown -R postgres:postgres /pgdatabase/data

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
sudo cp /tmp/conf/*.conf ${prefix} 
echo "config done"

# start nginx and reload config
export PATH=$PATH:/usr/local/pgsql/bin
pg_ctl -D /pgdatabase/data/ -l /pgdatabase/data/start.log start

# keep the container running, so we can attach to it
echo "run 'sudo docker exec -it postgres_postgres_1 bash' to obtain a shell into the container"
echo "run psql -p 5432 to connect to it"
echo "psql -f /tmp/sql/xxxx.sql to run the query"

tail -f /dev/null
#/bin/bash
