import 'package:currency_pickers/country.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plus_one/src/styling/color_palettes.dart';
import 'package:currency_pickers/currency_pickers.dart';


class PaymentOptionsPage extends StatefulWidget {
  @override
  _PaymentOptionsPageState createState() => _PaymentOptionsPageState();
}

class _PaymentOptionsPageState extends State<PaymentOptionsPage> {
  Country _selectedDialogCountry =
      CurrencyPickerUtils.getCountryByCurrencyCode('INR');


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: sixtyPercOrange,
        title: Center(
            child: Text(
          'PlusOne',
          style: TextStyle(
              color: unselectedGray, fontWeight: FontWeight.bold, fontSize: 25),
        )),
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: unselectedGray,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        actions: [
          Icon(
            Icons.call,
            color: Colors.transparent,
          ),
          Icon(
            Icons.call,
            color: Colors.transparent,
          )
        ],
      ),
      body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
            padding: EdgeInsets.fromLTRB(15, 20, 15, 5),
            child: Text(
              "Preferred Currency",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 15,
              ),
            ),
          ),
                ListTile(
                  onTap: _openCurrencyPickerDialog,
                  title: _buildDialogItem(_selectedDialogCountry),
                ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30),
            decoration: BoxDecoration(
              color: Colors.black12,
            ),
            width: 400,
            height: 1,
          ),
        ],
        
      ),
    );
  }


  Widget _buildDialogItem(Country country) => Row(
    mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(width: 20.0),
          CurrencyPickerUtils.getDefaultFlagImage(country),
          SizedBox(width: 20.0),
          Flexible(child: Text(country.name)),
          Text(" (${country.currencyCode})")

        ],
      );

  void _openCurrencyPickerDialog() => showDialog(
        context: context,
        builder: (context) => Theme(
            data: Theme.of(context).copyWith(primaryColor: seafoamGreen),
            child: CurrencyPickerDialog(
                titlePadding: EdgeInsets.fromLTRB(6.0, 8, 6, 8),
                searchCursorColor: seafoamGreen,
                searchInputDecoration: InputDecoration(hintText: 'Search'),
                isSearchable: true,
                title: Text('Select your preferred currency'),
                onValuePicked: (Country country) =>
                    setState(() => _selectedDialogCountry = country),
                itemBuilder: _buildDialogItem)),
      );

  


}