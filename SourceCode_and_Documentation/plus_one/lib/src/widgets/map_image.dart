import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:plus_one/src/providers/event.dart';
import 'package:intl/intl.dart';

class MapImage extends StatefulWidget {
  final List<Event> eventLocs;
  final DateTime dt;

  MapImage({@required this.eventLocs, @required this.dt});
  @override
  _MapImageState createState() => _MapImageState();
}

class _MapImageState extends State<MapImage> {
  GoogleMapController mapController;

  final Map<String, Marker> _markers = {};

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;

    setState(() {
      _markers.clear();

      for (final place in widget.eventLocs) {
        final marker = Marker(
          markerId: MarkerId(place.id),
          position: LatLng(place.lat, place.long),
          infoWindow: InfoWindow(
            title: place.title,
          ),
        );
        _markers[place.id] = marker;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String dt = DateFormat('kk:mm dd/MM').format(widget.dt);

    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            height: 500,
            width: 400,
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: LatLng(
                  widget.eventLocs[0].lat,
                  widget.eventLocs[0].long,
                ),
                zoom: 13.0,
              ),
              markers: _markers.values.toSet(),
            ),
          ),
          Positioned(
            bottom: 10,
            left: 50,
            child: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.black,
                  )),
              child: Container(
                // width: 30,
                height: 30,
                child: Row(
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      child: Image.asset(
                        'assets/images/prototype_icons/calendar.png',
                      ),
                    ),
                    Text(dt),
                    VerticalDivider(
                      width: 20,
                      color: Colors.grey,
                      thickness: 2,
                      indent: 2,
                      endIndent: 3,
                    ),
                    Icon(Icons.contacts_rounded),
                    Text("Friends")
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
