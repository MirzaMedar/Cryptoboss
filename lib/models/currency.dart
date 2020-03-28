class CryptoCurrency {
  String id;
  String rank;
  String symbol;
  String price;
  String name;
  bool changed;
  bool increased;
  String percentage;

  CryptoCurrency({this.id, this.rank, this.symbol, this.price, this.name, this.changed = false, this.increased = false, this.percentage = ''});
}
