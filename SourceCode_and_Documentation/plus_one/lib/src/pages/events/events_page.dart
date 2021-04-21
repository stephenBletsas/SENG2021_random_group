import 'package:flutter/material.dart';
import 'package:plus_one/src/styling/custom_text_styles.dart';
import 'package:plus_one/src/styling/color_palettes.dart';
import 'package:plus_one/src/providers/paths.dart';
import 'package:plus_one/src/widgets/path_card.dart';
import 'package:provider/provider.dart';

class EventsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final donePaths = Provider.of<Paths>(context).getSelectedPaths();
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
          value: donePaths[i],
          child: PathCard(),
        ),
        itemCount: donePaths.length,
        padding: const EdgeInsets.all(10.0),
      ),
      // floatingActionButton: Container(
      //   decoration: BoxDecoration(
      //     borderRadius: BorderRadius.circular(30),
      //     color: Colors.green,
      //   ),
      //   child: IconButton(
      //     icon: Icon(Icons.add),
      //     onPressed: () =>
      //         Navigator.of(context).pushNamed(CreatePath.routeName),
      //   ),
      // ),
    );
  }
}
