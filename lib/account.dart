import 'package:localstorage/localstorage.dart';
import 'package:atm/account_data.dart';

class Account {
  final LocalStorage _storage;
  final AccountData _accountData;

  Account(this._storage, this._accountData);
}
