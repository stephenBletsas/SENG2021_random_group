import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/paths.dart';
import '../widgets/path_card.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final pathsData = Provider.of<Paths>(context);
    final paths = pathsData.paths;

    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
          value: paths[i],
          child: PathCard(),
        ),
        itemCount: paths.length,
        padding: const EdgeInsets.all(10.0),
      ),
    );
  }
}
