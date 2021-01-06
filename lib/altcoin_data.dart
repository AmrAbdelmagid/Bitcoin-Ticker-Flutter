import 'networking.dart';
import 'dart:developer';

const coinapiURL = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = '7DB7DE4E-4C04-4C23-A0E7-81ED3DC0F155';

class AltcoinData {

  Future<dynamic> getAltcoinData(String currency,String coinName) async{
    var url = '$coinapiURL/$coinName/$currency?apikey=$apiKey';
    NetworkHelper networkHelper = NetworkHelper(url: url);
    var altcoinData = await networkHelper.getData();
    return altcoinData;
  }

}