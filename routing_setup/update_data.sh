#!/bin/bash

# Specify the file name without extension
FILENAME=western-india-latest

# Navigate to the custom_files directory
cd /home/ubuntu/custom_files

# Download the latest Geofabrik data with a temporary name
wget http://download.geofabrik.de/asia/india/western-zone-latest.osm.pbf -O "$FILENAME".osm.pbf.tmp

# Remove the old data (optional, if you want to save disk space)
rm "$FILENAME".osm.pbf

# Rename the downloaded data to the desired name
mv "$FILENAME".osm.pbf.tmp "$FILENAME".osm.pbf

