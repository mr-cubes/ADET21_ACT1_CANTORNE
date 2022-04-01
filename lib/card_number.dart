class CardNumber {
  late final int _value;

  CardNumber(int value) {
    var sum = 0;

    sum += value % 10;
    value = value ~/ 10;

    sum += (value % 10) * 2;
    value = value ~/ 10;

    sum += value % 10;
    value = value ~/ 10;

    sum += (value % 10) * 2;
    value = value ~/ 10;

    sum += value % 10;
    value = value ~/ 10;

    sum += (value % 10) * 2;
    value = value ~/ 10;

    if (sum % 10 != 0) {
      throw Exception("Invalid credit card number");
    }

    _value = value;
  }

  static CardNumber parse(String value) {
    return CardNumber(int.parse(value));
  }

  @override
  int get hashCode => _value.hashCode;

  @override
  String toString() {
    return _value.toString().padLeft(6, '0');
  }
}
