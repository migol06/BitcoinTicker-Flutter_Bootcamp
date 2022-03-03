import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const _baseURL = 'https://rest.coinapi.io/v1/exchangerate';
const _apiKey = '86EA56EA-F164-4B12-93E5-D51D8F31A230';

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

class CoinData {
  Future getAPI(String currency) async {
    Map<String, String> cryptoRates = {};
    for (String crypto in cryptoList) {
      http.Response response = await http
          .get(Uri.parse('$_baseURL/$crypto/$currency?apikey=$_apiKey'));
      if (response.statusCode == 200) {
        double getRate = jsonDecode(response.body)['rate'];
        debugPrint(getRate.toStringAsFixed(2));
        cryptoRates[crypto] = getRate.toStringAsFixed(2);
      } else {
        debugPrint(response.statusCode.toString());
      }
    }

    return cryptoRates;
  }
}
