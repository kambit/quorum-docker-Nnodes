#/bin/bash
sudo docker kill $(sudo docker ps -qa)
sudo docker rm $(sudo docker ps -qa)
sudo ./setup.sh
sudo docker-compose up -d
sudo docker ps -a
