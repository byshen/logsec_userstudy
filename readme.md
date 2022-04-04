
```bash
git submodule update --init --recursive


# compile it first!
cd eval_postgres
./configure --prefix=/opt/PostgreSQL
make -j8

# automatically set up
# if you are doing experiment for orignal version, comment TYPE in postgres/run.sh
cd ../postgres/
docker-compose build
docker-compose up


# Vsftpd
cd ../vsftpd/
docker-compose build
docker-compose up

# need to run the command to show the differences before the participant
```
