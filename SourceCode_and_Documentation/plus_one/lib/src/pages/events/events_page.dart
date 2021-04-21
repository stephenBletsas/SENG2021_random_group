import 'package:flutter/material.dart';
import 'package:plus_one/src/providers/event.dart';
import 'package:plus_one/src/providers/events.dart';

import 'package:provider/provider.dart';

class EventsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Provider.of<EventsList>(context).getCEvents(DateTime.now());
    return Scaffold(
      body: Center(
        child: Text("hello"),
      ),
    );
  }
}
