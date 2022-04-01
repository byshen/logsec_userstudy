
```bash
# compile it first!
cd eval_postgres
./configure --prefix=/opt/PostgreSQL
make -j8

# automatically set up
# if you are doing experiment for orignal version, comment TYPE in postgres/run.sh
cd ../postgres/
docker-compose build
docker-compose up
```
