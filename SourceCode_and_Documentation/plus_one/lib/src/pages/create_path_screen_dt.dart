import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plus_one/src/pages/view_path_screen.dart';
import 'package:plus_one/src/providers/path.dart';
import 'package:plus_one/src/providers/paths.dart';
import 'package:provider/provider.dart';
import '../styling/color_palettes.dart';
import '../styling/custom_text_styles.dart';
import 'package:intl/intl.dart';

class CreatePath extends StatefulWidget {
  static const routeName = '/create-path';
  @override
  _CreatePathState createState() => _CreatePathState();
}

class _CreatePathState extends State<CreatePath> {
  DateTime _time = DateTime.now();
  DateTime _date = DateTime.now();
  final DateFormat dateFormatter = DateFormat('dd-MM-yyyy');
  final DateFormat timeFormatter = DateFormat('Hms');
  final _formKey = GlobalKey<FormState>();

  TextEditingController title = new TextEditingController();
  TextEditingController description = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    final pathsList = Provider.of<Paths>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: sixtyPercOrange,
        title: Text(
          'PlusOne',
          style: buildLogoTextStyle(40),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(15),
            width: double.infinity,
            height: MediaQuery.of(context).copyWith().size.height / 5,
            child: Text(
              "WHEN DO YOU WANT TO GO ON YOUR ADVENTURE?",
              style: buildBoldRobotoText(30, Colors.blue),
            ),
          ),
          Container(
            padding: EdgeInsets.all(15),
            width: double.infinity,
            // height: MediaQuery.of(context).copyWith().size.height / 5,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  buildTextField(context, "TITLE", title),
                  buildTextField(context, "DESCRIPTION", description),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  builder: (BuildContext builder) {
                    return Container(
                      height: MediaQuery.of(context).copyWith().size.height / 3,
                      child: CupertinoDatePicker(
                        initialDateTime: DateTime.now(),
                        onDateTimeChanged: (DateTime newdate) {
                          setState(() {
                            _date = newdate;
                          });
                        },
                        mode: CupertinoDatePickerMode.date,
                      ),
                    );
                    // Navigator.of(context).popUntil((route) => false)
                  });
            },
            child: Text('SELECT DATE'),
          ),
          SizedBox(height: 10),
          Text(
            'Selected Date: ${dateFormatter.format(_date)}',
          ),
          SizedBox(height: 15),
          ElevatedButton(
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  builder: (BuildContext builder) {
                    return Container(
                      height: MediaQuery.of(context).copyWith().size.height / 3,
                      child: CupertinoDatePicker(
                        initialDateTime: DateTime.now(),
                        onDateTimeChanged: (DateTime newdate) {
                          setState(() {
                            _time = newdate;
                          });
                        },
                        mode: CupertinoDatePickerMode.time,
                      ),
                    );
                    // Navigator.of(context).popUntil((route) => false)
                  });
            },
            child: Text('SELECT TIME'),
          ),
          SizedBox(height: 10),
          Text(
            'Selected time: ${timeFormatter.format(_time)}',
          ),
        ],
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.green,
        ),
        child: IconButton(
            icon: Icon(Icons.done),
            onPressed: () {
              Path newPath = Path(
                id: 'P${_date.toString()}',
                title: title.text,
                description: "Description",
                events: [],
                image: '',
              );
              pathsList.addPath(newPath);
              Navigator.of(context).pushReplacementNamed(
                  ViewPathScreen.routeName,
                  arguments: newPath.id);
            }),
      ),
    );
  }

  Widget buildTextField(
      BuildContext context, String label, TextEditingController controller) {
    return Column(children: [
      Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: 20.0, bottom: 8.0),
        child: Text(
          label,
          style: buildRobotoTextStyle(20.0, Colors.black),
        ),
      ),
      Container(
        alignment: Alignment.center,
        child: Theme(
          data: ThemeData(
            primaryColor: seafoamGreen,
          ),
          child: SizedBox(
            width: double.infinity,
            height: 36.0,
            child: buildTextFormField(controller),
          ),
        ),
      ),
    ]);
  }

  Widget buildTextFormField(TextEditingController controller) {
    return TextFormField(
      maxLines: 1,
      controller: controller,
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter a Title';
        }
        return null;
      },
      showCursor: true,
      decoration: InputDecoration(
        errorStyle: TextStyle(height: 0.5),
        contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0))),
        filled: true,
        fillColor: Colors.grey[200].withOpacity(0.75),
      ),
      style: buildRobotoTextStyle(14.0, Colors.black),
    );
  }
}
