import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = '939FE634-C8F7-487F-ACC6-5C8ACEB3149B';

class CoinData {
  Future getCoinData(String selectedCurrency) async {
    Map<String, String> cryptoCoinRate = {};
    for (String crypto in cryptoList) {
      String url = '$coinAPIURL/$crypto/$selectedCurrency?apiKey=$apiKey';
      http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        cryptoCoinRate[crypto] =
            jsonDecode(response.body)['rate'].toStringAsFixed(0);
      } else {
        if (kDebugMode) {
          print(response.statusCode);
        }
        throw ('Issue in GET request');
      }
    }
    return cryptoCoinRate;
  }
}
