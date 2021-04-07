import 'package:flutter/material.dart';
import 'package:plus_one/src/styling/custom_text_styles.dart';

class FocusSheet extends StatelessWidget {
  final String title;
  final String description;

  FocusSheet({
    @required this.title,
    @required this.description,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            child: Text(
              title,
              style: buildBoldRobotoText(
                40,
                Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.orangeAccent,
              borderRadius: BorderRadius.circular(20),
            ),
            padding: EdgeInsets.all(15),
            child: Text(
              description,
              style: buildRobotoTextStyle(
                20,
                Colors.black,
              ),
            ),
          )
        ],
      ),
    );
  }
}
