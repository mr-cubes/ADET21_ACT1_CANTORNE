import 'dart:io';
import 'dart:convert';

import 'package:atm/account.dart';
import 'package:atm/account_data.dart';
import 'package:atm/card_number.dart';
import 'package:atm/name.dart';

class BankService {
  final Map<int, AccountData> _map = {};
  final File _file = File("bank_data.json");

  static final BankService _instance = BankService._internal();
  BankService._internal();

  factory BankService() {
    var jsonString = _instance._file.readAsStringSync();

    var jsonMap = json.decode(jsonString) as Map<String, dynamic>;

    for (var entry in jsonMap.entries) {
      var pinHash = entry.value["pin-hash"];
      var firstName = entry.value["first-name"];
      var middleName = entry.value["middle-name"];
      var lastName = entry.value["last-name"];
      var extendedName = entry.value["extended-name"];
      var balance = entry.value["balance"];

      if (pinHash == null ||
          firstName == null ||
          middleName == null ||
          lastName == null ||
          extendedName == null ||
          balance == null) {
        throw Exception("Failed to load data");
      }

      _instance._map[int.parse(entry.key)] = AccountData(
          pinHash,
          Name(firstName, middleName, lastName, extendedName),
          double.parse(balance));
    }

    return _instance;
  }

  Account? openAccount(CardNumber cardNumber, String pin) {
    AccountData? item = _map[cardNumber.hashCode];

    if (item == null) {
      return null;
    }

    var accountData = item;

    if (!accountData.isPinMatch(pin)) return null;

    return Account(accountData);
  }

  void createAccount(
      CardNumber cardNumber, String pin, Name owner, double initialBalance) {
    if (_map[cardNumber] != null) {
      throw Exception("Account already exists");
    }

    _map[cardNumber.hashCode] =
        AccountData(AccountData.hashPin(pin), owner, initialBalance);
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

  static BankService getService() {
    return BankService._instance;
  }
}
