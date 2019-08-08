import 'networking.dart';

const url = 'https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC';

class CurrencyFetcher {
  dynamic fetchBitcoinCurrency(String to) async {
    var networkHelper = NetworkHelper(url + to);

    var jsonData = await networkHelper.getData();

    return jsonData['last'];
  }
}
