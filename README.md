# go-redis-mysql

# docker-compose
```
> docker-compose up -d
```

# redis

# redis benchmark
```
# ping
redis-benchmark -n 100000 -q
redis-benchmark -t ping -n 100000 -q

# rpush,lpop
redis-benchmark -t rpush,lpop -q
redis-benchmark -t rpush,lpop -P 10 -q
```

## connect to redis
```
> redis-cli
or
> docker-compose exec order-service-redis redis-cli
```

## redis command
```
127.0.0.1:6379> keys *
127.0.0.1:6379> type "BITOETH_ACTION_QUEUE"
127.0.0.1:6379> llen "BITOETH_ACTION_QUEUE"
127.0.0.1:6379> LRANGE "BITOETH_ACTION_QUEUE" 0 10
```

# mysql

## connect to mysql
```
> mysql -uroot -p -h127.0.0.1
or
> docker-compose exec order-service-mysql mysql
mysql> show databases;
```

## import db schema
```
mysql> create database raichu_development;
> docker cp db/raichu_development.sql order-service-mysql:/tmp/raichu_development.sql
> docker-compose exec order-service-mysql bash
> mysql raichu_development < /tmp/raichu_development.sql
mysql> use raichu_development;
mysql> show tables;
```

# go test
```
go test -run NameOfTest
go test -bench BenchmarkRedisPingLoop
```

