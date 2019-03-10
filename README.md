# CircleMud for Docker
This repository contains a Dockerised version of [CircleMUD](https://www.circlemud.org/) 3.1. The following extensions have been installed;

- OasisOLC 2.0.6-3.1 by Harvey Gilpin

## Usage
To run an instance of CircleMUD run the following commands;

```
docker pull circlemud:latest

docker run --detach \
	--publish 4000:4000 \
	--volume /usr/circle/lib \
	--name circlemud \
	circlemud:latest
```

Once the container is running, you must connect to it to create the "Implementor" user. This user will be the privileged admin user, with this user it is possible to modify the world files from within the game.

## Building
You can build a custom CircleMUD instance by cloning this repository and making changes to the payloads that are deployed to the container. Patches can be applied to the CircleMUD engine by modifying the source files within `payloads/circle`. The files in this directory will be compiled once they have been deployed into the container.

The world files are stored in the `payloads/circle` directory. Changing these files will change the zones, rooms, mobiles and objects in the game. These files can also be modified from within the game by running the container in "development" mode.

The `build.sh` script automates the process of re-building the Docker image. Running this script will kill any existing containers, rebuild the image and then start a new instance from the image. If you provide a "dev" argument to the script then it will bind mount the world files into the container allowing you to modify them from within the game.

## License
CircleMUD is licensed software, I do not own any rights to it and all licenses and copyright notices have been left in place. This repository is just a repackaging of CircleMUD and a select few contributions in a Docker image. Please refer to the license in the `LICENSE` file included within this repository for more information about the creators of CircleMUD and DikuMUD.
