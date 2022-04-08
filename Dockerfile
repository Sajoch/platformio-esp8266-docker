FROM python:3.9.12 as builder
WORKDIR /var/app

# Download platformio-core
RUN pip install -U platformio==5.2.5

# Download esp8266 compiler
RUN pio platform install espressif8266 --with-package=framework-arduinoespressif8266 && pio system prune -f
