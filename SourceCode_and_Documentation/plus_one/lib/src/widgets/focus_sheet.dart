import 'package:flutter/material.dart';
import 'package:plus_one/src/styling/custom_text_styles.dart';

class FocusSheet extends StatelessWidget {
  final String title;
  final String description;

  FocusSheet({
    @required this.title,
    @required this.description,
  });

  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            child: Text(
              title,
              style: buildBoldRobotoText(
                40,
                Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            // color: Colors.blue,
            height: 325,
            // width: 400,
            padding: EdgeInsets.all(10),
            child: Scrollbar(
              // isAlwaysShown: true,
              controller: _scrollController,
              child: ListView.builder(
                controller: _scrollController,
                itemBuilder: (ctx, i) => (i == 0)
                    ? Container(
                        width: 350,
                        decoration: BoxDecoration(
                          // color: Colors.orangeAccent,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: EdgeInsets.all(15),
                        child: Text(
                          description,
                          style: buildRobotoTextStyle(
                            20,
                            Colors.black,
                          ),
                          // softWrap: true,
                        ),
                      )
                    : Container(
                        width: 350,
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          child: Image.asset(
                            'assets/images/prototype_icons/coogee map.PNG',
                            width: double.infinity,
                            fit: BoxFit.cover,
                            height: 200,
                          ),
                        ),
                      ),
                itemCount: 2,
                scrollDirection: Axis.horizontal,
                // padding: EdgeInsets.all(10),
              ),
              thickness: 10,
            ),
          ),

          // Container(
          //   decoration: BoxDecoration(
          //     color: Colors.orangeAccent,
          //     borderRadius: BorderRadius.circular(20),
          //   ),
          //   padding: EdgeInsets.all(15),
          //   child: Text(
          //     description,
          //     style: buildRobotoTextStyle(
          //       20,
          //       Colors.black,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
