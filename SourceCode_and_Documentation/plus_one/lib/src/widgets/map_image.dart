import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapImage extends StatefulWidget {
  @override
  _MapImageState createState() => _MapImageState();
}

class _MapImageState extends State<MapImage> {
  GoogleMapController mapController;
  final LatLng _center = const LatLng(-33.920365, 151.258279);
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    // @required
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            height: 400,
            width: 400,
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 15.0,
              ),
            ),
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
              width: 100,
              height: 50,
              // padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 50,
                    child: Image.asset(
                      'assets/images/prototype_icons/sun.png',
                      // semanticsLabel: 'Acme Logo',
                    ),
                  ),
                  Text(
                    "33",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  )
                ],
              ),
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
                    Text("01/04/21       10:30am"),
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
