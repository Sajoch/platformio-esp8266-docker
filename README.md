## Introduction
Use a [PlatformIO](https://github.com/platformio/platformio-core) and an [Arduino framework](https://github.com/esp8266/Arduino) to build an application for [ESP8266](https://www.espressif.com/en/products/modules/esp8266) inside a [docker](https://www.docker.com/) container.  

## Usage
### Build the docker image
* Get last tag from the git repository
```bash
TAG=$(git describe --tags --abbrev=0)
```
* Build and tag your image
```bash
docker build -t platformio-esp8266:${TAG} .
```
* And you can publish it to your [private docker registy](https://hub.docker.com/_/registry). 
```bash
docker push myRegistry.com/platformio-esp8266:${TAG}
```

### Build your app
```dockerfile
FROM platformio-esp8266:1.0.0 as builder

# Download project dependencies
COPY platformio.ini .
RUN pio lib install

# Copy source
COPY include include
COPY lib lib
COPY test test
COPY src src

# Copy libraries imported by npm
COPY --from=dependenties /var/app/node_modules/ lib

# Build app
RUN pio run

# Copy binary
COPY --from=builder /var/app/.pio/build/esp12e/firmware.bin .
```
