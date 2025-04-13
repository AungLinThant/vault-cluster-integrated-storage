#check whether docker run or not
docker ps
docker ps -a
docker volume ls

#run docker-compose up
docker-compose.yaml up

docker ps
docker ps -a
docker volume ls

#login to each docker container1,2,3
docker exec -it vault-container1 sh
docker exec -it vault-container2 sh
docker exec -it vault-container3 sh

#vault status in each 3 containers (init, seal, storage type)
vault status

#vault init in container1 only
vault operator init

#check again vault status, will see initialized and 5unseal key & token
vault status

#unseal it in container1,you must supply at least 3 of these keys to unseal it
before it can start servicing requests
vault operator unseal xxx
vault operator unseal xxx
vault operator unseal xxx

vault status

vault login xxx

vault operator raft list-peers

#go to container2 & 3
docker exec -it vault-container2 sh
docker exec -it vault-container3 sh

vault status
#Note: will see init=false, sealed=true. no need init in container2&3 coz
will use as single cluster for all 3containers

#put raft join cmd in both container 2&3
vault operator raft join http://vault-server1:8200

vault status  (will see init is true coz they combined as single cluster)

#But, in raft list-peers in container1 will not appear as follower for
container2 & 3 yet. coz they both need unseal

#unseal in container2 & 3
vault operator unseal xxx
vault operator unseal xxx
vault operator unseal xxx

#check again vault status
vault status  (will see unseal = false )

#vault login for container2 & 3
vault login xxx

#raft join for container2 & 3, type it in both
vault operator raft join http://vault-server1:8200

Then, u can test create secret key in one vault server,
will see this secret key in all 3 vault server.
