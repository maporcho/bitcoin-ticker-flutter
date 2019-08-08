import 'networking.dart';

const url = 'https://apiv2.bitcoinaverage.com/indices/global/ticker/';

class CurrencyFetcher {
  dynamic convertCurrency(String from, String to) async {
    var networkHelper = NetworkHelper(url + from + to);

    var jsonData = await networkHelper.getData();

    return jsonData['last'];
  }
}
