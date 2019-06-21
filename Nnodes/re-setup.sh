#/bin/bash
docker rm -f $(docker ps -a | grep "quorum" | awk '{print $1}')
sudo ./setup.sh
sudo docker-compose up -d
sudo docker ps -a
