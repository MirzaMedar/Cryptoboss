import 'package:cryptoboss/models/currency.dart';
import 'package:flutter/foundation.dart';

class CurrenciesData extends ChangeNotifier {
  List<CryptoCurrency> _items = [];

  void setList(List<CryptoCurrency> list) {
    this._items = list;
    notifyListeners();
  }

  int getLength() {
    return _items.length;
  }

  void updateItem(String currencyId, String price) {
    var item = _items.firstWhere((item) => item.id == currencyId);
    item.percentage =
        _calculatePercentage(double.parse(item.price), double.parse(price))
            .toStringAsFixed(6);
    item.changed = true;
    item.increased = double.parse(price) > double.parse(item.price);
    item.price = price;
    notifyListeners();
  }

  CryptoCurrency getByIndex(int index) => _items[index];

  double _calculatePercentage(double oldValue, double newValue) {
    return ((newValue - oldValue) / (oldValue) * 100).abs();
  }
}
