import 'package:bitcoin_ticker/price_screen.dart';
import 'package:flutter/material.dart';
import 'altcoin_data.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  @override
  void initState() {
    super.initState();
    altcoinData();
  }

  void altcoinData() async {
    AltcoinData altcoinData = AltcoinData();
    var BTCdata = await altcoinData.getAltcoinData('USD','BTC');
    var ETHdata = await altcoinData.getAltcoinData('USD','ETH');
    var LTCdata = await altcoinData.getAltcoinData('USD','LTC');
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return PriceScreen(
        initialBTCData: BTCdata,initialETHData: ETHdata,initialLTCData: LTCdata,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}