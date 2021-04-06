import 'package:flutter/material.dart';
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
      // appBar: AppBar(
      //   backgroundColor: Colors.orange,
      //   title: Text(
      //     "PlusOne",
      //     style: TextStyle(
      //       fontSize: 50,
      //       fontStyle: FontStyle.italic,
      //       color: Colors.white,
      //     ),
      //   ),
      // ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text('PlusOne'),
            // Allows the user to reveal the app bar if they begin scrolling back
            // up the list of items.
            floating: true,
            backgroundColor: Colors.orange,

            // Display a placeholder widget to visualize the shrinking size.
            // flexibleSpace: Placeholder(),
            // Make the initial height of the SliverAppBar larger than normal.
            expandedHeight: 20,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (ctx, i) {
                if (i == 1) {
                  return Container(
                    child: Stack(
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          child: Image.network(
                            path.image,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            height: 200,
                          ),
                        ),
                      ],
                    ),
                  );
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
      // body: Column(
      //   children: [
      //     Container(
      //       padding: EdgeInsets.all(10),
      //       child: Text(
      //         path.title,
      //         style: TextStyle(fontSize: 30),
      //         textAlign: TextAlign.center,
      //       ),
      //       width: double.infinity,
      //     ),
      //     Container(
      //       child: Stack(
      //         children: <Widget>[
      //           ClipRRect(
      //             borderRadius: BorderRadius.all(Radius.circular(15)),
      //             child: Image.network(
      //               path.image,
      //               width: double.infinity,
      //               fit: BoxFit.cover,
      //               height: 200,
      //             ),
      //           ),
      //         ],
      //       ),
      //     ),
      //     ListView.builder(
      //       itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
      //         value: path.events[i],
      //         child: EventCard(),
      //       ),
      //       itemCount: path.events.length,
      //     ),
      //   ],
      // ),
    );
  }
}
