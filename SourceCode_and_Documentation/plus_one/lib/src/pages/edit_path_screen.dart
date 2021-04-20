import 'package:flutter/material.dart';
import 'package:plus_one/src/pages/view_path_screen.dart';
import 'package:provider/provider.dart';

import '../providers/paths.dart';
import '../styling/custom_text_styles.dart';
import '../styling/color_palettes.dart';
import '../widgets/map_image.dart';
import '../widgets/event_card.dart';
import '../providers/event.dart';

class EditPathScreen extends StatelessWidget {
  static const routeName = '/edit-path';
  @override
  Widget build(BuildContext context) {
    final pathId = ModalRoute.of(context).settings.arguments as String;
    final path = Provider.of<Paths>(context, listen: false).findById(pathId);
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text(
              "Edit Path",
              style: buildBoldRobotoText(30, Colors.black),
            ),
            // Allows the user to reveal the app bar if they begin scrolling back
            // up the list of items.
            floating: true,
            backgroundColor: sixtyPercOrange,
            expandedHeight: 20,
            actions: [
              IconButton(
                icon: Icon(
                  Icons.save_rounded,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  // popNamed(
                  //   ViewPathScreen.routeName,
                  //   arguments: pathId,
                  // );
                },
              )
            ],
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (ctx, i) {
                if (i == 1) {
                  return Text("MAP");
                } else if (i == 0) {
                  return Container(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      path.title,
                      style: TextStyle(fontSize: 30),
                      textAlign: TextAlign.center,
                    ),
                    width: double.infinity,
                  );
                } else {
                  Event event = path.events[i - 2];
                  return EventCard(event: event);
                }
              },
              childCount: path.events.length + 2,
            ),
          )
        ],
      ),
    );
  }
}
