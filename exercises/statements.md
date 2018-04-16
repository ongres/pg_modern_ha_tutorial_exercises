##Statements

These exercises are intended to be completed during the practical part of PGConfUS18's
talk "Tutorial on modern PostgreSQL High Availability". Their purpose is to test two of 
the proposed HA solutions in PostgreSQL environment: Patroni and Stolon

###Patroni

In order to do this part, you need to locate in the `patroni` folder.

####Setup
```
docker build --no-cache . -t patroni:latest
docker-compose up -d
```
The user is `postgres` and the password is `postgres` too.

####Exercises
1. Connect to the entrypoint and create a table `t1`
2. Discover, via PostgreSQL, which of the nodes is the master
3. Discover, via etcd, which of the nodes is the master
4. Try to insert in `t1` through entrypoint
5. Try to insert in `t1` through replica node
6. Try to insert in `t1` through master node
7. Stop master node
8. Find out who became master
9. Create a table `t2` through entrypoint
10. Try to insert in `t2` through replica node
11. Try to insert in `t2` through master node
12. Rejoin stopped node
13. Check that the rejoined node is a standby and it contains `t2`
14. Check master node's replication table and see both replicas are replicating from master

### Stolon

In order to do this part, you need to locate in the `stolon` folder.

####Setup
```
make build
export ETCD_TOKEN=<some-token>
make compose-up
docker-compose scale keeper=3
```
The user is `postgres` and the password has been randomly generated at `etc/secrets/pgsql`.

####Exercises
1. Connect to the entrypoint and create a table `t1`
2. Discover, via stolonctl and via PostgreSQL, which of the nodes is the master
3. Try to gather as much information as possible via etcd
4. Try to insert in `t1` through entrypoint
5. Try to insert in `t1` through replica node
6. Try to insert in `t1` through master node
7. Stop master node
8. Check `sentinel`'s logs to see what's going on
9. Find out who became master
10. Create a table `t2` through entrypoint
11. Try to insert in `t2` through replica node
12. Try to insert in `t2` through master node
13. Try to rejoin stopped node
