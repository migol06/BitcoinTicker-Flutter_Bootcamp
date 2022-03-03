import 'package:bitcoin_ticker/coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PriceScreen extends StatefulWidget {
  const PriceScreen({Key? key}) : super(key: key);

  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  String? rate;

  Future<void> getData() async {
    var currencyRate = await CoinData().getAPI(selectedCurrency);
    setState(() {
      rate = currencyRate;
    });
  }

  CupertinoPicker cupertinoPicker() {
    List<Text> cupertinoPicker = [];
    for (String currency in currenciesList) {
      var text = Text(currency);
      cupertinoPicker.add(text);
    }
    return CupertinoPicker(
        backgroundColor: Colors.lightBlue,
        itemExtent: 20.0,
        onSelectedItemChanged: (value) {
          setState(() {
            selectedCurrency = currenciesList[value];
          });
          getData();
        },
        children: cupertinoPicker);
  }

  DropdownButton<String> dropDownAndroid() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String currency in currenciesList) {
      var items = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropdownItems.add(items);
    }

    return DropdownButton<String>(
        value: selectedCurrency,
        items: dropdownItems,
        onChanged: (_value) {
          setState(() {
            selectedCurrency = _value!;
            getData();
          });
        });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    return Scaffold(
      appBar: AppBar(
        title: const Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = $rate $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
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
            padding: const EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: isIOS ? cupertinoPicker() : dropDownAndroid(),
          ),
        ],
      ),
    );
  }
}
