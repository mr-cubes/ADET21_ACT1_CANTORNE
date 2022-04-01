import 'dart:convert';

import 'package:crypto/crypto.dart' as crypto;
import 'package:atm/name.dart';

class AccountData {
  late String _correctHash;
  late Name _owner;
  late double _balance;

  AccountData(String pinHash, Name owner, double initialBalance) {
    _correctHash = pinHash;
    _owner = owner;
    _balance = initialBalance;
  }

  bool isPinMatch(String pin) {
    var hash = hashPin(pin);
    return hash == _correctHash;
  }

  static String hashPin(String pin) {
    var pinBytes = utf8.encode(pin);
    var md5Bytes = crypto.md5.convert(pinBytes).bytes;

    var buffer = StringBuffer();

    for (var byte in md5Bytes) {
      buffer.write(byte.toRadixString(16).padLeft(2, '0'));
    }

    return buffer.toString();
  }

  String get jsonString => '''{
"pin-hash":"$_correctHash",
"first-name":"${_owner.firstName}",
"middle-name":"${_owner.middleName}",
"last-name":"${_owner.lastName}",
"extend-name":"${_owner.extendedName}",
"balance":"$_balance"
}''';
}
