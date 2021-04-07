import 'package:flutter/material.dart';
import 'package:plus_one/src/widgets/map_image.dart';
import 'package:provider/provider.dart';

import '../providers/paths.dart';
import '../widgets/event_card.dart';
import '../providers/event.dart';

class ViewPathScreen extends StatelessWidget {
  static const routeName = '/view-path';
  @override
  Widget build(BuildContext context) {
    final pathId = ModalRoute.of(context).settings.arguments as String;
    final path = Provider.of<Paths>(context, listen: false).findById(pathId);

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text('PlusOne'),
            // Allows the user to reveal the app bar if they begin scrolling back
            // up the list of items.
            floating: true,
            backgroundColor: Colors.orange,
            expandedHeight: 20,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (ctx, i) {
                if (i == 1) {
                  return MapImage();
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
