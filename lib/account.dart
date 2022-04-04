import 'package:atm/account_data.dart';
import 'package:atm/name.dart';

class Account {
  final AccountData _accountData;

  Account(this._accountData);

  Name getOwner() => _accountData.owner;
}
