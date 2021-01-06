import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'coin_data.dart';
import 'altcoin_data.dart';
import 'dart:developer';

class PriceScreen extends StatefulWidget {
  PriceScreen({this.initialBTCData,this.initialETHData,this.initialLTCData});
  final initialBTCData;
  final initialETHData;
  final initialLTCData;

  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {

  String currency;

  int handledCoinPrice1;
  int handledCoinPrice2;
  int handledCoinPrice3;



  @override
  void initState() {
    super.initState();
    updateUI(widget.initialBTCData,widget.initialETHData,widget.initialLTCData);
  }

  updateUI(dynamic initialBTCData, dynamic initialETHData, dynamic initialLTCData){
    setState(() {
      currency = initialBTCData['asset_id_quote'];

      var coinPrice1 = initialBTCData['rate'];
      handledCoinPrice1 = coinPrice1.toInt();

      var coinPrice2 = initialETHData['rate'];
      handledCoinPrice2 = coinPrice2.toInt();

      var coinPrice3 = initialLTCData['rate'];
      handledCoinPrice3 = coinPrice3.toInt();
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
        var initialBTCData = await AltcoinData().getAltcoinData(value,cryptoList[0]);
        var initialETHData = await AltcoinData().getAltcoinData(value,cryptoList[1]);
        var initialLTCData = await AltcoinData().getAltcoinData(value,cryptoList[2]);
        updateUI(initialBTCData,initialETHData,initialLTCData);
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
          buildPriceCard(coinName: cryptoList[0],handledCoinPrice: handledCoinPrice1),
          buildPriceCard(coinName: cryptoList[1],handledCoinPrice: handledCoinPrice2),
          buildPriceCard(coinName: cryptoList[2],handledCoinPrice: handledCoinPrice3),
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

  Padding buildPriceCard({String coinName, int handledCoinPrice}) {
    return Padding(
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
        );
  }
}
