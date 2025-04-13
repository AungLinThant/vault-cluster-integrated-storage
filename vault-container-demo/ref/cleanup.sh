docker stop dev-vault-server{1..3}
docker rm dev-vault-server{1..3}
docker ps
docker ps -a
docker volume ls

list_volumes() {
    docker volume ls --format "{{.Name}}" $filter
}

echo "## Docker Volumes"
volumes=$(list_volumes)
echo $volumes
docker colume rm $volumes