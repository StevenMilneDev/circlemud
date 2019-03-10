# CircleMud for Docker

This repository contains a Dockerised version of [CircleMUD](https://www.circlemud.org/) 3.1. The following contributed patches have been installed;

- OasisOLC 2.0.6-3.1 by Harvey Gilpin
- auto-medit by Jason Yarber

## Usage
To run an instance of CircleMUD run the following commands;

```bash
docker pull circlemud:latest

docker run --detach \
	--publish 4000:4000 \
	--volume /usr/circle/lib \
	--name circlemud \
	circlemud:latest
```

Once the container has been started, you can connect to the game through telnet on port 4000. The first user created on an instance will be the "Implementor" which is a privileged user that can modify the game world, make sure you login and create this account straight away.

## Building

You can build a custom CircleMUD instance by cloning this repository and making changes to the files that are deployed to the container. Patches can be applied to the CircleMUD engine by modifying the source files within the `circle/` directory. The files in this directory will be compiled once they have been deployed into the container.

The world files are stored in the `state/world/` directory. Changing these files will change the zones, rooms, mobiles and objects in the game. These files can also be modified from within the game by running the container in "development" mode.

General text used by the engine like the greeting text, message of the day text, policies, credits etc. can be found in the `state/text/` directory. It is advised that you change this text to reference your own MUD.

CircleMUD has a collection of contributed patches, these can be installed by placing the patch files within the `patches/` directory. It is advised to follow a naming convention when placing patch files in this folder. The patches will be applied in alphabetical order, you can prefix a number to the patch filename to specify the order it should be applied in. The patch installer script will execute any `.sh` files with the same name as a patch file, this allows you to modify the source before the patch is applied. For example if there was a patch file named `001-my.patch`, then its installer script would be named `001-my.patch.sh`.

The `build.sh` script automates the process of re-building the Docker image. Running this script will kill any existing containers, rebuild the image and then start a new instance from the image. If you provide a "dev" argument to the script then it will bind mount the world files into the container allowing you to modify them from within the game.

## License

CircleMUD is licensed software, I do not own any rights to it and all licenses and copyright notices have been left in place. This repository is just a repackaging of CircleMUD and a select few contributions in a Docker image. Please refer to the license in the `LICENSE` file included within this repository for more information about the creators of CircleMUD and DikuMUD.
