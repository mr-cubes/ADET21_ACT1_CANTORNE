class CardNumber {
  late final int _value;

  CardNumber(int value) {
    var sum = 0;

    sum += value % 10;
    value = (value / 10) as int;

    sum += (value % 10) * 2;
    value = (value / 10) as int;

    sum += value % 10;
    value = (value / 10) as int;

    sum += (value % 10) * 2;
    value = (value / 10) as int;

    sum += value % 10;
    value = (value / 10) as int;

    sum += (value % 10) * 2;
    value = (value / 10) as int;

    if (sum % 10 != 0) {
      throw Exception("Invalid credit card number");
    }

    _value = value;
  }

  @override
  int get hashCode => _value.hashCode;

  @override
  String toString() {
    return _value.toString().padLeft(6, '0');
  }
}
