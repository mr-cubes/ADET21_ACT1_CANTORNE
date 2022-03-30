import 'dart:convert';
import 'package:crypto/crypto.dart' as crypto;

class AccountData {
  String _correctHash;

  AccountData(this._correctHash);

  bool isPinMatch(String pin) {
    var bytes = utf8.encode(pin);
    var hash = utf8.decode(crypto.md5.convert(bytes).bytes);

    return hash == _correctHash;
  }
}
