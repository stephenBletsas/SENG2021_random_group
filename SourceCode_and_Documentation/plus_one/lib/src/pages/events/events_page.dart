import 'package:flutter/material.dart';
import 'package:plus_one/src/pages/edit_path_screen.dart';
import 'package:plus_one/src/providers/event.dart';
import 'package:plus_one/src/providers/events.dart';
import 'package:plus_one/src/styling/color_palettes.dart';
import 'package:plus_one/src/styling/custom_text_styles.dart';
import 'package:plus_one/src/widgets/event_card.dart';
import 'package:plus_one/src/widgets/location_preview.dart';
import 'package:plus_one/src/widgets/map_image.dart';
import 'package:provider/provider.dart';

class EventsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Event> events = Provider.of<EventsList>(context).events;
    return Scaffold(
        body: CustomScrollView(
      slivers: <Widget>[
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (ctx, i) {
              return EventCard(
                event: events[i],
                dt: DateTime.now(),
              );
            },
            childCount: events.length,
          ),
        )
      ],
    ));
  }
}
