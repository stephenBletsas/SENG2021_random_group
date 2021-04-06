import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/path.dart';

class PathCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final pathData = Provider.of<Path>(context, listen: false);
    return InkWell(
      onTap: () {},
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 10,
        margin: EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  child: Image.network(
                    pathData.image,
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
                      color: Colors.black38,
                    ),
                    width: 300,
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: Text(
                      pathData.title,
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontStyle: FontStyle.italic),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Positioned(
                    // top: 10,
                    bottom: 10,
                    left: 10,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.black38,
                      ),
                      child: Row(
                        children: [
                          Container(
                            child: Icon(
                              Icons.calendar_today,
                              color: Colors.white,
                            ),
                          ),
                          Container(
                            width: 100,
                            // padding:
                            //     EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                            child: Text(
                              "00/00/00",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                              softWrap: true,
                              overflow: TextOverflow.fade,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
