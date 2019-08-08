import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'coin_data.dart';
import 'services/currency_fetch.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  var btcConverted;
  var ethConverted;
  var ltcConverted;

  androidDropdownButton() => DropdownButton<String>(
      value: selectedCurrency,
      items: currenciesList
          .map((value) => DropdownMenuItem(
                child: Text(value),
                value: value,
              ))
          .toList(),
      onChanged: (value) {
        setState(() {
          selectedCurrency = value;
          updateCurrency();
        });
      });

  iosPicker() => CupertinoPicker(
        backgroundColor: Colors.lightBlue,
        itemExtent: 32.0,
        onSelectedItemChanged: (selectedIndex) {
          setState(() {
            selectedCurrency = currenciesList[selectedIndex];
            updateCurrency();
          });
        },
        children: currenciesList.map((value) => Text(value)).toList(),
      );

  @override
  void initState() {
    super.initState();
    btcConverted = '?';
    ethConverted = '?';
    ltcConverted = '?';
    updateCurrency();
  }

  void updateCurrency() async {
    var _btcConverted =
        await CurrencyFetcher().convertCurrency('BTC', selectedCurrency);
    var _ethConverted =
        await CurrencyFetcher().convertCurrency('ETH', selectedCurrency);
    var _ltcConverted =
        await CurrencyFetcher().convertCurrency('LTC', selectedCurrency);

    setState(() {
      btcConverted = _btcConverted;

      ethConverted = _ethConverted;

      ltcConverted = _ltcConverted;
    });
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
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              CryptoCard(
                  fromCurrency: 'BTC',
                  toCurrency: selectedCurrency,
                  value: btcConverted.toString()),
              CryptoCard(
                  fromCurrency: 'ETH',
                  toCurrency: selectedCurrency,
                  value: ethConverted.toString()),
              CryptoCard(
                  fromCurrency: 'LTC',
                  toCurrency: selectedCurrency,
                  value: ltcConverted.toString()),
            ],
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isAndroid ? androidDropdownButton() : iosPicker(),
          ),
        ],
      ),
    );
  }
}

class CryptoCard extends StatelessWidget {
  final String fromCurrency;
  final String toCurrency;
  final String value;

  CryptoCard({this.fromCurrency, this.toCurrency, this.value});

  @override
  Widget build(BuildContext context) {
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
            "1 $fromCurrency = $value $toCurrency",
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
