#!/bin/bash

# Stop the existing container
docker stop valhalla_gis-ops

# Remove the stopped container
docker rm valhalla_gis-ops

# Start a new container with the updated data
docker run -dt --name valhalla_gis-ops --net=host -p 8002:8002 -v /root/custom_files:/custom_files ghcr.io/gis-ops/docker-valhalla/valhalla:latest

