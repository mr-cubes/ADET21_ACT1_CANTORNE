class CardNumber {
  final int _value;

  @override
  String toString() {
    return _value.toString().padLeft(6, '0');
  }
}
