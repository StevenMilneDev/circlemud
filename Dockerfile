FROM ubuntu:18.10

# Install required software
RUN apt-get update && apt-get install -y \
   gcc \
	 make \
	 patch

# Copy the CircleMUD engine and world state into the container
COPY ./circle /usr/circle
COPY ./config.c /usr/circle/src/config.c
COPY ./state/world /usr/circle/lib/world
COPY ./state/text /usr/circle/lib/text

# Apply patches to the engine
COPY ./install-patches.sh /usr/circle/install-patches.sh
COPY ./patches /usr/circle/patch
RUN cd /usr/circle && ./install-patches.sh || echo "WARNING: One or more patches failed to install"

# Compile engine
RUN cd /usr/circle && \
	./configure && \
	cd src && \
	make

# Expose a volume to contain the world state
VOLUME /usr/circle/lib

EXPOSE 4000

CMD ["/bin/bash", "-c", "cd /usr/circle && ./autorun"]
