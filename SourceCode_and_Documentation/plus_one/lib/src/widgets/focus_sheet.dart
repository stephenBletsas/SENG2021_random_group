import 'package:flutter/material.dart';

class FocusSheet extends StatelessWidget {
  final String title;

  FocusSheet({@required this.title});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            child: Text(
              title,
              style: Theme.of(context).textTheme.title,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
