class CardNumber {
  late final int _value;

  CardNumber(int value) {
    var sum = 0;
    var weight = 0;
    _value = value;

    // digit 0
    weight = value % 10;
    sum += weight;
    value = value ~/ 10;

    // digit 1
    weight = (value % 10) * 2;
    sum += (weight % 10) + (weight ~/ 10);
    value = value ~/ 10;

    // digit 2
    weight = value % 10;
    sum += weight;
    value = value ~/ 10;

    // digit 3
    weight = (value % 10) * 2;
    sum += (weight % 10) + (weight ~/ 10);
    value = value ~/ 10;

    // digit 4
    weight = value % 10;
    sum += weight;
    value = value ~/ 10;

    // digit 5
    weight = (value % 10) * 2;
    sum += (weight % 10) + (weight ~/ 10);
    value = value ~/ 10;

    if (sum % 10 != 0) {
      throw Exception("Invalid credit card number");
    }
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
