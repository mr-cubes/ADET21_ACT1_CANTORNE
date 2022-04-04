import 'package:atm/account.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  final Account account;

  const Dashboard(this.account, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => DashboardState();
}

class DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Row(children: []));
  }
}
