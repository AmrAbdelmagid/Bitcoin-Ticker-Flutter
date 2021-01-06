import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'coin_data.dart';
import 'altcoin_data.dart';
import 'dart:developer';

class PriceScreen extends StatefulWidget {
  PriceScreen({this.initialAtcoinData});
  final initialAtcoinData;

  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {

  String coinName;
  String currency;
  int handledCoinPrice;


  @override
  void initState() {
    super.initState();
    updateUI(widget.initialAtcoinData);
  }

  updateUI(dynamic altcoinData){
    setState(() {
      coinName = altcoinData['asset_id_base'];
      currency = altcoinData['asset_id_quote'];
      double coinPrice = altcoinData['rate'];
      handledCoinPrice = coinPrice.toInt();
    });
  }


  DropdownButton<String> androidDropDownButton() {
    List<DropdownMenuItem<String>> dropDownItemsList = [];
    for (String currency in currenciesList) {
      DropdownMenuItem<String> listItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropDownItemsList.add(listItem);
    }
    return DropdownButton<String>(
      value: currency,
      items: dropDownItemsList,
      onChanged: (value) async {
        var altcoinData = await AltcoinData(currency: value).getAltcoinData();
        updateUI(altcoinData);
      },
    );
  }

  CupertinoPicker iOSCupertinoPicker() {
    List<Text> cupertinoItemsList = [];
    for (String currency in currenciesList) {
      Text listItem = Text(
        currency,
        style: TextStyle(color: Colors.white),
      );
      cupertinoItemsList.add(listItem);
    }
    return CupertinoPicker(
      selectionOverlay: null,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {},
      children: cupertinoItemsList,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 $coinName = $handledCoinPrice $currency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child:
                Platform.isIOS ? iOSCupertinoPicker() : androidDropDownButton(),
          ),
        ],
      ),
    );
  }
}
