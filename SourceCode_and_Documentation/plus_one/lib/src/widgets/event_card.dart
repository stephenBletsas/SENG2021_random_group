import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/events.dart';
import '../providers/event.dart';

class EventCard extends StatelessWidget {
  final Event event;
  EventCard({
    @required this.event,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
            side: BorderSide(color: Colors.black, width: 4)),
        elevation: 5,
        margin: EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(0)),
                  child: Image.network(
                    // pathData.image,
                    event.imageUrl,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    height: 150,
                  ),
                ),
                // Positioned(
                //   top: 10,
                //   // bottom: 10,
                //   left: 10,
                //   child: Container(
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(15),
                //       color: Colors.black38,
                //     ),
                //     width: 300,
                //     padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                //     child: Text(
                //       event.title,
                //       style: TextStyle(
                //           fontSize: 25,
                //           color: Colors.white,
                //           fontStyle: FontStyle.italic),
                //       softWrap: true,
                //       overflow: TextOverflow.fade,
                //       textAlign: TextAlign.center,
                //     ),
                //   ),
                // ),
                // Positioned(
                //     // top: 10,
                //     bottom: 10,
                //     left: 10,
                //     child: Container(
                //       decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(15),
                //         color: Colors.black38,
                //       ),
                //       child: Row(
                //         children: [
                //           Container(
                //             // decoration: BoxDecoration(
                //             //   borderRadius: BorderRadius.circular(15),
                //             //   color: Colors.black38,
                //             // ),
                //             child: Icon(
                //               Icons.calendar_today,
                //               color: Colors.white,
                //             ),
                //           ),
                //           Container(
                //             // decoration: BoxDecoration(
                //             //   borderRadius: BorderRadius.circular(15),
                //             //   // color: Colors.black38,
                //             // ),
                //             width: 100,
                //             // padding:
                //             //     EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                //             child: Text(
                //               "00/00/00",
                //               style: TextStyle(
                //                 fontSize: 20,
                //                 color: Colors.white,
                //               ),
                //               softWrap: true,
                //               overflow: TextOverflow.fade,
                //               textAlign: TextAlign.center,
                //             ),
                //           ),
                //         ],
                //       ),
                //     )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
