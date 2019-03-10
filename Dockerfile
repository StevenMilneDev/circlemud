FROM ubuntu:18.10

# Install required software
RUN apt-get update && apt-get install -y \
   gcc \
	 make

# Copy engine payload into container
COPY ./engine.tar.gz /usr/circlemud.tar.gz
RUN cd /usr && \
	gunzip circlemud.tar.gz && \
	tar -xf circlemud.tar && \
	rm circlemud.tar

# Copy the initial world state into the container
COPY ./world.tar.gz /usr/circle/world.tar.gz
RUN cd /usr/circle && \
	gunzip world.tar.gz && \
	tar -xf world.tar && \
	rm world.tar

# Copy engine configuration into container
COPY ./config.c /usr/circle/src/config.c

# Compile engine
RUN cd /usr/circle && \
	./configure && \
	cd src && \
	make

# Expose a volume to contain the world state
VOLUME /usr/circle/lib

EXPOSE 4000

CMD ["/bin/bash", "-c", "cd /usr/circle && ./autorun"]
