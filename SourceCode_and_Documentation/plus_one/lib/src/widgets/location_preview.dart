import 'package:flutter/material.dart';
import 'package:plus_one/src/providers/event.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
    return GoogleMap(
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
        target: LatLng(
          widget.event.lat,
          widget.event.long,
        ),
        zoom: 17.0,
      ),
      markers: _markers.toSet(),
      // markers: _markers.toSet(),
    );
  }
}
