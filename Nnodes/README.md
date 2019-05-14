# Setup N Quorum Nodes

```
git clone https://github.com/coolcode/quorum-docker-Nnodes
cd quorum-docker-Nnodes
sudo docker build -t quorum .
cd Nnodes
sudo ./setup.sh
sudo docker-compose up -d
```

DONE!

# Test

```
sudo docker exec -it nnodes_node_1_1 geth attach /qdata/dd/geth.ipc

> admin.peers.length
```
