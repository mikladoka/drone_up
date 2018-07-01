# drone_up


1. Create ubuntu machine
1. Clone this repo onto that machine
1. [Setup github oauth application](https://github.com/paralect/deploy-drone/blob/master/OAUTH_APP.md) & create a drone.env file in the project root.

```
#FILE="./drone.env"

/bin/cat <<EOM >$FILE
# Drone secret key, used for private communication between agents and web UI
DRONE_SECRET=
DRONE_GITHUB_CLIENT=
DRONE_GITHUB_SECRET=
DRONE_ADMIN=
EOM
```
4. Run start_up script. This will install all prerequisites and start drone.

