import 'package:plus_one/src/styling/color_palettes.dart';
import 'package:flutter/material.dart';
import 'package:plus_one/src/styling/custom_text_styles.dart';
import 'package:plus_one/src/utils/age_calculator.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PersonalDetailsPage extends StatefulWidget {
  @override
  _PersonalDetailsPageState createState() => _PersonalDetailsPageState();
}

class _PersonalDetailsPageState extends State<PersonalDetailsPage> {
  bool _valueMale = false;
  bool _valueFemale = false;
  bool _valueOther = false;

  // Create a list of text controller and use it to retrieve the current value
  // of the TextField.
  TextEditingController nameTextController = new TextEditingController();
  TextEditingController dobTextController = new TextEditingController();

  DateTime dobSelectedDate;

  void _onCheckMale(bool value) =>
      setState(() => {_valueMale = value, _valueFemale = _valueOther = false});
  void _onCheckFemale(bool value) =>
      setState(() => {_valueFemale = value, _valueMale = _valueOther = false});
  void _onCheckOther(bool value) =>
      setState(() => {_valueOther = value, _valueMale = _valueFemale = false});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        resizeToAvoidBottomInset: false,

        body: Center(
            child: SizedBox(
                width: 240,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // TITLE
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.only(top: 30.0, bottom: 20.0),
                        child: Text(
                          "ENTER YOUR DETAILS",
                          style: buildRobotoTextStyle(28.0, blackCoral),
                        ),
                      ),

                      Form(
                          key: _formKey,
                          child: Column(children: [
                            buildTextField(context, "Name", nameTextController),
                            buildGenderSelection(context),
                            GestureDetector(
                              onTap: () => _selectDate(context),
                              child: AbsorbPointer(
                                child: buildTextField(context, "Date of Birth",
                                    dobTextController),
                              ),
                            )
                          ])),

                      // NEXT BUTTON
                      Container(
                        width: 400.0,
                        height: 48.0,
                        margin: const EdgeInsets.only(top: 30.0, bottom: 20.0),
                        child: RaisedButton(
                          color: orange,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50.0))),
                          textColor: Colors.white,
                          onPressed: () {
                            // Validate returns true if the form is valid, otherwise false.
                            if (_formKey.currentState.validate()) {
                              next();
                            }
                          },
                          child: Text(
                            "NEXT",
                            style: buildRobotoTextStyle(14.0, Colors.white),
                          ),
                        ),
                      ),
                    ]))));
  }

  void next() {
    if (!(_valueFemale || _valueMale || _valueOther) ||
        (_valueFemale && _valueMale) ||
        (_valueMale && _valueOther) ||
        (_valueOther && _valueFemale)) {
      return;
    }

    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => UploadPhotoPage(fromProfile: false,)),
    // );
  }

  Future<Null> _selectDate(BuildContext context) async {
    DateTime picked = await showDatePicker(
        builder: (context, child) {
          return Theme(
            data: ThemeData.light().copyWith(
                colorScheme: ColorScheme.light(primary: orange),
                buttonTheme:
                    ButtonThemeData(textTheme: ButtonTextTheme.primary)),
            child: child,
          );
        },
        context: context,
        // Initial date defaults to 18 years back from today
        initialDate: DateTime.now().subtract(Duration(days: (18 * 365 + 2))),
        firstDate: DateTime(1901, 1),
        lastDate: DateTime.now());

    // show toast when the user is under 18
    // and default dobSelectedDate will be automatically picked
    if (calculateAge(picked) < 18) {
      setState(() {
        Fluttertoast.showToast(
            msg: "You have to be at least 18 years old to join PlusOne.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: lightGray,
            textColor: blackCoral);
        picked = dobSelectedDate;
      });
    }

    if (picked != null)
      setState(() {
        dobSelectedDate = picked;
        dobTextController.value = TextEditingValue(
            text: picked.toString().substring(0, "YYYY-MM-DD".length));
        // If we want DD-MM-YYYY : (picked.toString().substring(8,10)+'-'+picked.toString().substring(5,7)+'-'+picked.toString().substring(0,4))
      });
  }

  Widget buildTextField(
      BuildContext context, String label, TextEditingController controller) {
    return Column(children: [
      Container(
        alignment: Alignment.centerLeft,
        margin: EdgeInsets.only(top: 20.0, bottom: 8.0),
        child: Text(
          label,
          style: buildRobotoTextStyle(14.0, blackCoral),
        ),
      ),
      Container(
          alignment: Alignment.centerLeft,
          child: Theme(
            data: ThemeData(
              primaryColor: orange,
            ),
            child: SizedBox(
                width: 240.0,
                height: 36.0,
                child: TextFormField(
                  maxLines: 1,
                  controller: controller,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter valid information';
                    }
                    return null;
                  },
                  showCursor: true,
                  decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 10.0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50.0))),
                    filled: true,
                    fillColor: Colors.grey[200].withOpacity(0.75),
                  ),
                  style: buildRobotoTextStyle(16, blackCoral),
                )),
          ))
    ]);
  }

  Widget buildGenderSelection(BuildContext context) {
    return Column(children: [
      Container(
        alignment: Alignment.centerLeft,
        margin: EdgeInsets.only(top: 20.0),
        child: Text(
          'Your gender?',
          style: buildRobotoTextStyle(14.0, blackCoral),
        ),
      ),
      buildCheckBoxColumn(context, _valueMale, _onCheckMale, "Male"),
      buildCheckBoxColumn(context, _valueFemale, _onCheckFemale, "Female"),
      buildCheckBoxColumn(context, _valueOther, _onCheckOther, "Other")
    ]);
  }

  Widget buildCheckBoxColumn(
      BuildContext context, bool value, Function onChanged, String label) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 10.0),
      child: Row(children: [
        Theme(
          data: ThemeData(unselectedWidgetColor: Colors.grey),
          child: Row(children: [
            SizedBox(
              height: 30.0,
              width: 20.0,
              child: Checkbox(
                value: value,
                onChanged: onChanged,
                checkColor: Colors.white,
                activeColor: orange,
              ),
            ),

            // Horizontal padding
            SizedBox(
              width: 10.0,
            ),

            Text(
              label,
              style: buildRobotoTextStyle(14.0, blackCoral),
            ),
          ]),
        ),
      ]),
    );
  }
}
