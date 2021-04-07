import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MapImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // @required
    return Container(
      child: Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            child: Image.asset(
              'assets/images/prototype_icons/coogee map.PNG',
              width: double.infinity,
              fit: BoxFit.cover,
              height: 200,
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
                    child: SvgPicture.asset(
                      'assets/images/prototype_icons/sun.svg',
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
