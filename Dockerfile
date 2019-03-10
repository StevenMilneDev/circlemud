FROM ubuntu:18.10

# Install required software
RUN apt-get update && apt-get install -y \
   gcc \
	 make

# Copy payloads into the container
COPY ./circle /usr/circle
COPY ./config.c /usr/circle/src/config.c
COPY ./state/world /usr/circle/lib/world
COPY ./state/text /usr/circle/lib/text

# Compile engine
RUN cd /usr/circle && \
	./configure && \
	cd src && \
	make

# Expose a volume to contain the world state
VOLUME /usr/circle/lib

EXPOSE 4000

CMD ["/bin/bash", "-c", "cd /usr/circle && ./autorun"]
