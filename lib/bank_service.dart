import 'package:localstorage/localstorage.dart';

class BankService {
  final LocalStorage _storage = LocalStorage('bank_data');
  static final BankService _instance = BankService._internal();
  BankService._internal();

  factory BankService() {
    return _instance;
  }
}
