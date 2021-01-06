import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'coin_data.dart';
import 'altcoin_data.dart';
import 'dart:developer';

class PriceScreen extends StatefulWidget {
  PriceScreen({this.btcData,this.ethData,this.ltcData});
  final btcData;
  final ethData;
  final ltcData;

  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {

  String currency;

  int handledBTCPrice;
  int handledETHPrice;
  int handledLTCPrice;



  @override
  void initState() {
    super.initState();
    updateUI(widget.btcData,widget.ethData,widget.ltcData);
  }

  updateUI(dynamic btcData, dynamic ethData, dynamic ltcData){
    setState(() {

      if (btcData == null || ethData == null || ltcData == null){
        currency = 'USD';
        handledBTCPrice = 0;
        handledETHPrice = 0;
        handledLTCPrice = 0;
        return;
      }

        currency = btcData['asset_id_quote'];

        var btcPrice = btcData['rate'];
        handledBTCPrice = btcPrice.toInt();

        var ethPrice = ethData['rate'];
        handledETHPrice = ethPrice.toInt();

        var ltcPrice = ltcData['rate'];
        handledLTCPrice = ltcPrice.toInt();

    });
  }


  DropdownButton<String> androidDropDownButton() {
    List<DropdownMenuItem<String>> dropDownItemsList = [];
    for (String currency in currenciesList) {
      DropdownMenuItem<String> listItem = DropdownMenuItem(
        child: Text(currency,style: TextStyle(color: Colors.black),),
        value: currency,
      );
      dropDownItemsList.add(listItem);
    }
    return DropdownButton<String>(
      value: currency,
      items: dropDownItemsList,
      iconEnabledColor: Colors.black,
      dropdownColor: Colors.amber,
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
        style: TextStyle(color: Colors.black),
      );
      cupertinoItemsList.add(listItem);
    }
    return CupertinoPicker(
      selectionOverlay: null,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) async {
        var initialBTCData = await AltcoinData().getAltcoinData(currenciesList[selectedIndex],cryptoList[0]);
        var initialETHData = await AltcoinData().getAltcoinData(currenciesList[selectedIndex],cryptoList[1]);
        var initialLTCData = await AltcoinData().getAltcoinData(currenciesList[selectedIndex],cryptoList[2]);
        updateUI(initialBTCData,initialETHData,initialLTCData);
      },
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
          buildPriceCard(coinName: cryptoList[0],handledCoinPrice: handledBTCPrice),
          buildPriceCard(coinName: cryptoList[1],handledCoinPrice: handledETHPrice),
          buildPriceCard(coinName: cryptoList[2],handledCoinPrice: handledLTCPrice),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.amber,
            child:
                  Platform.isIOS ?  iOSCupertinoPicker() : androidDropDownButton(),
          ),
        ],
      ),
    );
  }

  Padding buildPriceCard({String coinName, int handledCoinPrice}) {
    return Padding(
          padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
          child: Card(
            color: Colors.amber,
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
                  color: Colors.black,
                ),
              ),
            ),
          ),
        );
  }
}
