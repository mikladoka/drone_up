#install docker
printf "==========================================\n"
printf "==========================================\n"
printf "==========================================\n"
printf "Installing docker\n"
sudo apt-get remove docker docker-engine docker.io
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
$(lsb_release -cs) \
stable"
sudo apt-get update
sudo apt-get install docker-ce -y

#install docker compose
printf "==========================================\n"
printf "==========================================\n"
printf "==========================================\n"
printf "Installing docker compose\n"
sudo curl -L https://github.com/docker/compose/releases/download/1.21.2/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

##todo change location?
FILE="./docker-compose.yml"

/bin/cat <<EOM >$FILE
version: '2'

services:
  drone-server:
    image: drone/drone:0.8.5
    ports:
      - 8000:8000
      - 9000:9000
    volumes:
      - ./drone-data:/var/lib/drone/
    env_file:
      - ./drone.env
    restart: always
    environment:
      - DRONE_OPEN=false
      - DRONE_GITHUB=true
      - DRONE_HOST=http://localhost:8000
      # Variables below set via drone.env file
      # - DRONE_GITHUB_CLIENT=
      # - DRONE_GITHUB_SECRET=
      # - DRONE_SECRET=

  drone-agent:
    image: drone/agent:0.8.5
    command: agent
    restart: always
    depends_on:
      - drone-server
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
    env_file:
      - ./drone.env
    environment:
      - DRONE_SERVER=drone-server:9000
      # Variables below set via drone.env file
      # - DRONE_SECRET=
EOM

printf "==========================================\n"
printf "==========================================\n"
printf "==========================================\n"
printf "Running docker compose\n"
sudo docker-compose --file ./docker-compose.yml up
