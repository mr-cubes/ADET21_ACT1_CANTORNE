import 'package:atm/account.dart';
import 'package:atm/account_data.dart';
import 'package:atm/card_number.dart';

class BankService {
  final Map<CardNumber, AccountData> _map = Map();

  static final BankService _instance = BankService._internal();
  BankService._internal();

  factory BankService() {
    return _instance;
  }

  Account? openAccount(CardNumber cardNumber, String pin) {
    AccountData? item = _map[cardNumber];

    if (item == null) {
      return null;
    }

    var accountData = item as AccountData;

    if (!accountData.isPinMatch(pin)) return null;

    return Account(accountData);
  }
}
