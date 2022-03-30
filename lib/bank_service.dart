import 'package:localstorage/localstorage.dart';
import 'package:atm/account.dart';
import 'package:atm/account_data.dart';

class BankService {
  final LocalStorage _storage = LocalStorage('bank_data');
  static final BankService _instance = BankService._internal();
  BankService._internal();

  factory BankService() {
    return _instance;
  }

  Account? openAccount(String cardNumber, String pin) {
    dynamic item = _storage.getItem("account#$cardNumber");
    if (item == null) {
      return null;
    }

    var accountData = item as AccountData;

    if (!accountData.isPinMatch(pin)) return null;

    return Account(_storage, accountData);
  }
}
