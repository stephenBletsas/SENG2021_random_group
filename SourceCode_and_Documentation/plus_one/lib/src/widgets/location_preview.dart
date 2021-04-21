import 'package:flutter/material.dart';
import 'package:plus_one/src/providers/event.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../providers/weather.dart';

class LocationPreview extends StatefulWidget {
  final Event event;

  LocationPreview({@required this.event});

  @override
  _LocationPreviewState createState() => _LocationPreviewState();
}

class _LocationPreviewState extends State<LocationPreview> {
  GoogleMapController mapController;

  final List<Marker> _markers = [];
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    setState(() {
      _markers.clear();

      final marker = Marker(
        markerId: MarkerId(widget.event.id),
        position: LatLng(widget.event.lat, widget.event.long),
        infoWindow: InfoWindow(
          title: widget.event.title,
        ),
      );
      _markers.add(marker);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: LatLng(
            widget.event.lat,
            widget.event.long,
          ),
          zoom: 17.0,
        ),
        markers: _markers.toSet(),
      ),
      Positioned(
        top: 10,
        // bottom: 10,
        left: 10,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.black26,
          ),
          // width: 100,
          height: 50,
          // padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                // width: 50,
                // child: Image.asset(
                //   'assets/images/prototype_icons/sun.png',
                //   // semanticsLabel: 'Acme Logo',
                // ),
                child: Text(Provider.of<Weather>(context).temp),
              ),
              Text(
                Provider.of<Weather>(context).desc,
                style: TextStyle(
                  color: Colors.black,
                ),
              )
            ],
          ),
        ),
      ),
    ]

        // markers: _markers.toSet(),
        );
  }
}
