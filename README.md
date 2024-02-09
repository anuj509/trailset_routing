# Build For Bharat | Hackathon | Scalable Solution

## Problem Statement

#### THEME: Logistics

#### PROBLEM NAME: Using open source maps

#### DESCRIPTION OF THE PROBLEM STATEMENT:
ONDC aims to democratise the e-commerce space and hence would contain amalgamation of a variety of Buyer Apps and Seller Apps.
For the network to reach that scale, it becomes imperative to use open source components to reduce the cost and make it affordable for even the smallest of the Buyer Apps and Seller apps.
The objective is to allow buyer and seller apps to use Open source maps for e-commerce functionality such as creating polygon(s) of points, generating motorable paths between 2 points, reverse-geocoding address to point on map, computing motorable distance between 2 points, mapping point to polygon / path interactively / using API, etc.
Point should support multiple representations such as gps coordinates, Google s2 cells, Uber h3 cells, etc.

#### SOLUTION EXPECTED & DELIVERABLES :
Showcase a solution that uses open source maps to enable functionality defined above; existing open source maps such as OpenStreetMap, Mapbox, etc. may be used.
All artefact used should be elaborated.
All assumptions should be elaborated.

## Solution

[![Logo](http://trailset.in)](https://github.com/anuj509/trailset_routing/blob/main/media/trailset_logo.svg)

## Trailset Routing: A Route Optimization API for Logistic Companies

Trailset Routing is an innovative solution aimed at empowering logistic companies with efficient route planning for their deliveries. Leveraging VROOM, an open-source optimization engine, and powered by Valhalla's robust capabilities, this API offers comprehensive features tailored to various real-life vehicle routing problems (VRP).

### Key Features:

1. **VROOM Integration**: Built upon [VROOM](https://github.com/VROOM-Project/vroom), our API supports a range of well-known vehicle routing problem types, including TSP, CVRP, VRPTW, MDHVRPTW, and PDPTW. Additionally, it can handle mixed problem types, ensuring versatility in route planning scenarios.

2. **Flexible Job and Shipment Management**: Trailset Routing facilitates the modeling of VRP with detailed job and shipment specifications. Users can define delivery/pickup amounts, service time windows, duration, priority, and more, enabling precise logistics management.

3. **Customizable Vehicle Settings**: With support for defining vehicle capacities, skills, working hours, and breaks, our API allows logistic companies to tailor route optimization to their fleet's unique requirements. Start and end points can be specified per vehicle, offering granular control over routing parameters.

4. **Valhalla Integration**: Harnessing the power of [Valhalla](https://github.com/valhalla/valhalla), Trailset Routing benefits from open-source data and a tiled hierarchical structure, enabling efficient offline routing and regional extracts. Dynamic costing of edges and vertices via plugin architecture ensures adaptive routing strategies and customization.

5. **Multi-Modal and Time-Based Routing**: Beyond traditional vehicle routing, our API supports multi-modal routing, accommodating auto, pedestrian, bike, and public transportation options. Time-based routes enable users to set arrival deadlines, enhancing scheduling precision.

### Technical Details

- **Engine**: Utilizes VROOM optimization engine and Valhalla's C++ based API for cross-platform compatibility and efficient routing on memory-constrained devices.
- **Map Data**: Geofabrik provides map data, ensuring comprehensive coverage for accurate routing calculations.
- **Geocoding**: Nominatin geocoding service is utilized for location-based services, enhancing address resolution and geospatial functionality.
- **Hosting**: Hosted on GCP Compute Engine VM c2-standard-4 (4vCPU 16GB Memory) 
- **OS**: Ubuntu 22.04.3 LTS
- **UI Support**: Developed on Flutter for web 3.13.4 with openstreetmap.
- **Containerization** : VROOM and Valhalla are hosted on Docker container.

### Setup
- Pre-requisite Flutter, Apache2, Docker installed
- Download Geofabrik map data [file](https://download.geofabrik.de/asia/india/western-zone-latest.osm.pbf) in custom_files directory. 
- Run the following Docker commands
    1. ```
        docker run -dt --name vroom --net=bridge -p 3000:3000 -v ~/trailset_routing/routing_setup/conf:/conf -e VROOM_ROUTER=valhalla vroomvrp/vroom-docker:v1.13.0```
    2. ```
        docker run -dt --name valhalla_gis-ops --net=bridge -p 8002:8002 -v ~/custom_files:/custom_files ghcr.io/gis-ops/docker-valhalla/valhalla:latest```
- ```bash
    cd trailset_routing
    flutter web build
    cp -a build/web/. /var/www/html/trailset_routing/
    ```
- configuring apache2
    ```
    cd /etc/apache2/sites-available
    nano 000-default.conf
    ```
- Restart apache2 after updating below config in `000-default.conf` file
    ```
    <VirtualHost *:80>
        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/html/trailset-routing
        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined
    </VirtualHost>

    ```
- ```
    sudo systemctl restart apache2
    ```
- Adjust GCP firewall to to allow api request at port 3000 and application should be up and running.


### API Documentation
- Swagger Document can be found [here](https://github.com/anuj509/trailset_routing/blob/main/docs/swagger.yaml)  
- Sample Request and Response can be found [here](https://github.com/anuj509/trailset_routing/tree/main/test/sample%20request)  
- Although, VROOM has provided extensive API document with example JSON. Take a look [here](https://github.com/VROOM-Project/vroom/blob/master/docs/API.md).  


### Demo

To illustrate the capabilities of Trailset Routing, we provide a live demo showcasing its intuitive interface and powerful features. Click [here](http://trailset.in/) to access the demo.

- Ideal usage where vehicles are selected, warehouse location is denoted by depo location 
[![Demo](https://img.youtube.com/vi/5f8kZVn4R44/maxresdefault.jpg)](https://youtu.be/5f8kZVn4R44)
- Adding stops manually
[![Manual stops](https://img.youtube.com/vi/5Qwhf2fIrgE/maxresdefault.jpg)](https://youtu.be/5Qwhf2fIrgE)
- Round trip and one way trip planning
[![Round Trip or One Way Trip](https://img.youtube.com/vi/enQYarg7_bA/maxresdefault.jpg)](https://youtu.be/enQYarg7_bA)
- Time window scheduling
[![Time Scheduling](https://img.youtube.com/vi/tRT2h_k-OF0/maxresdefault.jpg)](https://youtu.be/tRT2h_k-OF0)
- Priority stops in planning so don't miss out on important delivery point when less vehicles are available
[![Priority Stops](https://img.youtube.com/vi/28CUlmC-1aU/maxresdefault.jpg)](https://youtu.be/28CUlmC-1aU)


### Usage
- To use Trailset demo one can download standard template or download sample data file using `Template` button. 
- Once data file is ready, click on `Import Jobs` button. 
- Select Vehicle(s) as per need and customise vehicle properties and click `optimize`
- As response is received, map is populated with planned routes with stops in sequence.
- One can also manually add stop(s) using search functionality which uses [Nominatin](https://nominatim.org/release-docs/latest/api/Overview/) API


### Updating Map Data
We regularly retrieve map data from [Geofabrik](https://download.geofabrik.de/). Currently, the server acquires fresh map data for the western region of India on a daily basis. This routine is in place due to server capacity constraints, and it initiates the restart of the VROOM Docker to ensure that our routing engine operates with the most recent geographical information.

Western India [Data](https://download.geofabrik.de/asia/india/western-zone-latest.osm.pbf)

### Explanation

Trailset Routing simplifies the route optimization process for logistic companies by offering a user-friendly interface and robust backend powered by VROOM and Valhalla. By enabling precise job and shipment management, customizable vehicle settings, and multi-modal routing options, our API ensures efficient delivery logistics planning. Moreover, the seamless integration with external services such as Geofabrik for map data and Nominatin for geocoding enhances the accuracy and reliability of routing calculations. Whether it's optimizing routes for a small fleet or managing complex logistics operations for a large-scale enterprise, Trailset Routing provides the tools and flexibility needed to streamline delivery processes and enhance operational efficiency.

### UI Limitations
- Optimize up to 150 waypoints (compute limitation) but can be improved.
- Transport mode only "Truck" and mid-sized vehicle support available.
- Vehicle Capacity is restricted to 28 units only but configurable.
- Vehicle weight not considered in current api.
- Reverse logistic integration in planning api for pickups.


### Scope of Improvement
- Vehicle weight capacity planning
- Traffic Implementation Historical + Live
- Python Wrapper to handle caching, security, rate limiting
- Custom Nominatin Server for geocoding and lookup.
- Mechanism to speedup route planning.
- Different Vehicle modes in UI (Available in VROOM and Valhalla API).


### Real world Application by Parsel Exchange Pvt Ltd.
![Parsel TMS](https://github.com/anuj509/trailset_routing/blob/main/media/optimize_route%20plan.gif)


Trailset Routing is poised to revolutionize route optimization for logistic companies, offering a powerful, customizable, and user-friendly solution for their delivery logistics needs.