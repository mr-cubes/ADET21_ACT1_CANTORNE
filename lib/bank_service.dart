import 'package:atm/account.dart';
import 'package:atm/account_data.dart';
import 'package:atm/card_number.dart';
import 'package:atm/name.dart';

class BankService {
  final Map<int, AccountData> _map = Map();

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
}
