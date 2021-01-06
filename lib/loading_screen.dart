import 'package:bitcoin_ticker/price_screen.dart';
import 'package:flutter/material.dart';
import 'altcoin_data.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  Exception exception;

  @override
  void initState() {
    super.initState();
    altcoinData();
  }

  void altcoinData() async {
    try {
      AltcoinData altcoinData = AltcoinData();
      var initialBtcData = await altcoinData.getAltcoinData('EUR', 'BTC');
      var initialEthData = await altcoinData.getAltcoinData('EUR', 'ETH');
      var initialLtcData = await altcoinData.getAltcoinData('EUR', 'LTC');
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return PriceScreen(
          btcData: initialBtcData,
          ethData: initialEthData,
          ltcData: initialLtcData,
        );
      }));
    } catch (e) {
      exception = e;
    }
  }

  @override
  Widget build(BuildContext context) {
    return (exception == null)
        ? Scaffold(
            body: Center(
              child: SpinKitDualRing(
                color: Colors.amber,
                size: 100.0,
              ),
            ),
          )
        : Scaffold(
            body: Center(
              child: FlatButton(
                child: Text('Check Your Internet then PRESS HERE'),
                onPressed: altcoinData,
              ),
            ),
          );
  }
}
