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
    AltcoinData altcoinData = AltcoinData(currency: 'USD');
    var data = await altcoinData.getAltcoinData();
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return PriceScreen(
        initialAtcoinData: data,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

// coinName = data['asset_id_base'];
// currency = data['asset_id_quote'];
// coinPrice = data['rate'];
