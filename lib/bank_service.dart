import 'dart:io';

import 'package:atm/account.dart';
import 'package:atm/account_data.dart';
import 'package:atm/card_number.dart';
import 'package:atm/name.dart';

class BankService {
  final Map<int, AccountData> _map = Map();
  final File _file = File("bank_data.json");

  static final BankService _instance = BankService._internal();
  BankService._internal();

  factory BankService() {
    return _instance;
  }

  Account? openAccount(CardNumber cardNumber, String pin) {
    AccountData? item = _map[cardNumber.hashCode];

    if (item == null) {
      return null;
    }

    var accountData = item as AccountData;

    if (!accountData.isPinMatch(pin)) return null;

    return Account(accountData);
  }

  void createAccount(
      CardNumber cardNumber, String pin, Name owner, double initialBalance) {
    if (_map[cardNumber] != null) {
      throw Exception("Account already exists");
    }

    _map[cardNumber.hashCode] = AccountData(pin, owner, initialBalance);
  }

  void saveState() {
    var sink = _file.openWrite();

    sink.writeln('{');

    for (var entry in _map.entries) {
      sink.write('"${entry.key}": ${entry.value.jsonString}');

      if (entry.key != _map.entries.last.key) {
        sink.writeln(',');
      }
    }

    sink.writeln('}');

    sink.close();
  }
}
