import 'package:flutter/material.dart';

class FocusSheet extends StatelessWidget {
  final List<String> focusStuff;
  final String title;

  FocusSheet({@required this.title, @required this.focusStuff});
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
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(3),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10)),
                  margin: EdgeInsets.all(5),
                  height: 350,
                  width: 350,
                  child: title == "Ingredients"
                      ? ListView.builder(
                          itemCount: focusStuff.length,
                          itemBuilder: (ctx, index) {
                            return Card(
                              color: Theme.of(context).accentColor,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10),
                                child: Text(
                                  focusStuff[index],
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            );
                          },
                        )
                      : ListView.builder(
                          itemCount: focusStuff.length,
                          itemBuilder: (ctx, index) {
                            return Column(
                              children: <Widget>[
                                ListTile(
                                  leading: CircleAvatar(
                                    child: Text("# ${(index + 1)}"),
                                  ),
                                  title: Text(focusStuff[index],
                                      style: TextStyle(fontSize: 20)),
                                ),
                                Divider(),
                              ],
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
