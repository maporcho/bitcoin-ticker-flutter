import 'networking.dart';

const url = 'https://apiv2.bitcoinaverage.com/indices/global/ticker/BTCUSD';

class CurrencyFetcher {
  dynamic fetchCurrency() async {
    var networkHelper = NetworkHelper(url);

    var jsonData = await networkHelper.getData();

    return jsonData['last'];
  }
}
