import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plus_one/src/providers/event.dart';
import 'package:plus_one/src/styling/custom_text_styles.dart';
import 'package:plus_one/src/widgets/location_preview.dart';

class FocusSheet extends StatefulWidget {
  final String title;
  final String description;
  final Event event;

  FocusSheet({
    @required this.title,
    @required this.description,
    @required this.event,
  });

  @override
  _FocusSheetState createState() => _FocusSheetState(
      // description: description,
      // title: title,
      );
}

class _FocusSheetState extends State<FocusSheet> {
  // final String title;
  // final String description;

  // _FocusSheetState({
  //   @required this.title,
  //   @required this.description,
  // });

  int segmentedControlGroupValue = 0;
  void changeState(value) {
    if (segmentedControlGroupValue == 1) {
      setState(() {
        segmentedControlGroupValue = 0;
      });
    } else {
      setState(() {
        segmentedControlGroupValue = 1;
      });
    }
    // segmentedControlGroupValue = value;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            child: Text(
              widget.title,
              style: buildBoldRobotoText(
                40,
                Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          segmentedControlGroupValue == 0
              ? Container(
                  // height: 300,
                  // width: 350,
                  decoration: BoxDecoration(
                    // color: Colors.orangeAccent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.all(15),
                  child: Text(
                    widget.description,
                    style: buildRobotoTextStyle(
                      20,
                      Colors.black,
                    ),
                    softWrap: true,
                  ),
                )
              : Container(
                  // width: 350,
                  height: 300,
                  child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      child: LocationPreview(
                        event: widget.event,
                      )),
                ),
          Container(
            padding: EdgeInsets.all(5),
            child: CupertinoSlidingSegmentedControl(
              groupValue: segmentedControlGroupValue,
              children: <int, Widget>{
                0: Text("Description"),
                1: Text("Map"),
              },
              onValueChanged: changeState,
            ),
          ),
        ],
      ),
    );
  }
}
