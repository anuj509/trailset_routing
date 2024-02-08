
# Trailset Routing: A Route Optimization API for Logistic Companies

Trailset Routing is an innovative solution aimed at empowering logistic companies with efficient route planning for their deliveries. Leveraging VROOM, an open-source optimization engine, and powered by Valhalla's robust capabilities, this API offers comprehensive features tailored to various real-life vehicle routing problems (VRP).

## Key Features:

1. **VROOM Integration**: Built upon [VROOM](https://github.com/VROOM-Project/vroom), our API supports a range of well-known vehicle routing problem types, including TSP, CVRP, VRPTW, MDHVRPTW, and PDPTW. Additionally, it can handle mixed problem types, ensuring versatility in route planning scenarios.

2. **Flexible Job and Shipment Management**: Trailset Routing facilitates the modeling of VRP with detailed job and shipment specifications. Users can define delivery/pickup amounts, service time windows, duration, priority, and more, enabling precise logistics management.

3. **Customizable Vehicle Settings**: With support for defining vehicle capacities, skills, working hours, and breaks, our API allows logistic companies to tailor route optimization to their fleet's unique requirements. Start and end points can be specified per vehicle, offering granular control over routing parameters.

4. **Valhalla Integration**: Harnessing the power of [Valhalla](https://github.com/valhalla/valhalla), Trailset Routing benefits from open-source data and a tiled hierarchical structure, enabling efficient offline routing and regional extracts. Dynamic costing of edges and vertices via plugin architecture ensures adaptive routing strategies and customization.

5. **Multi-Modal and Time-Based Routing**: Beyond traditional vehicle routing, our API supports multi-modal routing, accommodating auto, pedestrian, bike, and public transportation options. Time-based routes enable users to set arrival deadlines, enhancing scheduling precision.

## Technical Details:

- **Engine**: Utilizes VROOM optimization engine and Valhalla's C++ based API for cross-platform compatibility and efficient routing on memory-constrained devices.
- **Map Data**: Geofabrik provides map data, ensuring comprehensive coverage for accurate routing calculations.
- **Geocoding**: Nominatin geocoding service is utilized for location-based services, enhancing address resolution and geospatial functionality.

Trailset Routing is poised to revolutionize route optimization for logistic companies, offering a powerful, customizable, and user-friendly solution for their delivery logistics needs.


## API Documentation
Since VROOM has provided extensive API document with example JSON. Take a look [here](https://github.com/VROOM-Project/vroom/blob/master/docs/API.md).  


## Updating Map Data
We regularly retrieve map data from [Geofabrik](https://download.geofabrik.de/). Currently, the server acquires fresh map data for the western region of India on a daily basis. This routine is in place due to server capacity constraints, and it initiates the restart of the VROOM Docker to ensure that our routing engine operates with the most recent geographical information.


## Demo

To illustrate the capabilities of Trailset Routing, we provide a live demo showcasing its intuitive interface and powerful features. Click [here](http://trailset.in/) to access the demo.

## Usage
- To use Trailset demo one can download standard template or download sample data file using `Template` button. 
- Once data file is ready, click on `Import Jobs` button. 
- Select Vehicle(s) as per need and customise vehicle properties and click `optimize`
- As response is received, map is populated with planned routes with stops in sequence.
- One can also manually add stop(s) using search functionality which uses [Nominatin](https://nominatim.org/release-docs/latest/api/Overview/) API


## Explanation

Trailset Routing simplifies the route optimization process for logistic companies by offering a user-friendly interface and robust backend powered by VROOM and Valhalla. By enabling precise job and shipment management, customizable vehicle settings, and multi-modal routing options, our API ensures efficient delivery logistics planning. Moreover, the seamless integration with external services such as Geofabrik for map data and Nominatin for geocoding enhances the accuracy and reliability of routing calculations. Whether it's optimizing routes for a small fleet or managing complex logistics operations for a large-scale enterprise, Trailset Routing provides the tools and flexibility needed to streamline delivery processes and enhance operational efficiency.


## Scope of Improvement
- Traffic Implementation Historical + Live
- Python Wrapper to handle caching, security, rate limiting
- Custom Nominatin Server for geocoding and lookup.
- Mechanism to speedup route planning.
- Different Vehicle modes in UI (Available in VROOM and Valhalla API).
