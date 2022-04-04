import 'package:flutter/services.dart';

class NumericalRangeFormatter extends TextInputFormatter {
  final double min;
  final double max;
  final double multiple;

  NumericalRangeFormatter(this.min, this.max, this.multiple);

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text == '') {
      return TextEditingValue(text: min.toStringAsFixed(2));
    }

    try {
      var value = double.parse(newValue.text);

      if (value < min) {
        return TextEditingValue(
            text: min.toStringAsFixed(2), selection: newValue.selection);
      }

      if (value > max) {
        return TextEditingValue(
            text: max.toStringAsFixed(2), selection: newValue.selection);
      }

      var remainder = value % multiple;

      if (remainder == 0) {
        return newValue;
      }

      return TextEditingValue(
          text: (value - remainder).toStringAsFixed(2),
          selection: newValue.selection);
    } catch (ex) {
      return oldValue;
    }
  }
}
