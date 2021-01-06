import 'networking.dart';
import 'dart:developer';

const coinapiURL = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = '7DB7DE4E-4C04-4C23-A0E7-81ED3DC0F155';

class AltcoinData {

  AltcoinData({this.currency});
  final currency;

  Future<dynamic> getAltcoinData() async{
    var url = '$coinapiURL/BTC/$currency?apikey=$apiKey';
    NetworkHelper networkHelper = NetworkHelper(url: url);
    var altcoinData = await networkHelper.getData();
    return altcoinData;
  }

}