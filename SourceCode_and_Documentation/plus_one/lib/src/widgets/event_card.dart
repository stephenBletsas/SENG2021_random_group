import 'package:flutter/material.dart';
import 'package:plus_one/src/styling/custom_text_styles.dart';
import 'package:provider/provider.dart';

import '../providers/events.dart';
import '../providers/event.dart';
import './focus_sheet.dart';

class EventCard extends StatelessWidget {
  final Event event;
  EventCard({
    @required this.event,
  });

  void _showFocusSheet(
    BuildContext ctx,
    String title,
    String description,
  ) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return Container(
          height: 700,
          child: GestureDetector(
            onTap: () {},
            child: FocusSheet(
              title: title,
              description: description,
            ),
            behavior: HitTestBehavior.opaque,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _showFocusSheet(context, event.title, event.description),
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(color: Colors.black, width: 2)),
        elevation: 20,
        margin: EdgeInsets.all(15),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Stack(
              alignment: Alignment.center,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  child: Image.network(
                    // pathData.image,
                    event.imageUrl,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    height: 150,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.black38,
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    event.title,
                    style: buildLogoTextStyle(30),
                    softWrap: true,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
