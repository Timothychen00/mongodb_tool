function clean_up {
    sleep 2
    echo "[Clean_up]stop Mongodb Docker"
    ID=$(cat container_ID.txt)
    if [ -z "$ID" ] 
    then
        echo "[Clean_up]No Container left to be cleaned" 
    else
        echo "[Clean_up]$ID needs to be cleaned!"
        sudo docker stop $ID
        sudo docker kill $ID
    fi
    osascript -e 'quit app "Docker Desktop"' 
    osascript -e 'quit app "MongoDB Compass"'
    >"container_ID.txt"
    exit 0
}

trap clean_up EXIT

echo "Mongodb Test Tool by TimothyChen"
sleep 1
echo "[script] dependency check"
#check and install
sh install_docker.sh
sh install_mongodb.sh

echo "[script] Docker install successfully! "
sleep 1
echo "[script] start running docker daemon!"
open -a docker
sleep 1
echo "[script] pulling image from MongoDB"
docker pull mongo
sleep 1
echo "[script] runnning local mongodb with no auth!!"
sleep 1
DOCKER_ID=$(docker run -p 27017:27017 -d  mongo)
# if [ $? -eq 125 ]
# then
while [ $? -eq 125 ];     do
    sleep 2
    echo "[script] retry"
    DOCKER_ID=$(docker run -p 27017:27017 -d  mongo)
done
# fi
echo $DOCKER_ID
echo $DOCKER_ID >> 'container_ID.txt'
echo $DOCEKR_ID "is runnning in the background"
echo "[script] starting mongodb compass"

open -a open -a "MongoDB Compass" --args mongodb://localhost:27017;
#


while true; do
    sleep 5
    echo "sleeping"
done