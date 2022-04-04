import 'package:atm/account.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Dashboard extends StatefulWidget {
  final Account account;

  const Dashboard(this.account, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => DashboardState();
}

class DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    var buttonStyle = ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.white70),
        fixedSize: MaterialStateProperty.all<Size>(const Size(256, 38)));
    var buttonTextStyle = const TextStyle(color: Colors.black87);

    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 40, 86, 212),
        body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(
              padding: const EdgeInsets.all(40),
              child: Text(
                  "Welcome ${widget.account.getOwner().toProperName()},\nwhat do you want to do?",
                  style: const TextStyle(color: Colors.white, fontSize: 20))),
          Padding(
              padding: const EdgeInsets.all(12),
              child: ElevatedButton(
                style: buttonStyle,
                child: Text("Check Balance", style: buttonTextStyle),
                onPressed: () {},
              )),
          Padding(
              padding: const EdgeInsets.all(12),
              child: ElevatedButton(
                style: buttonStyle,
                child: Text("Withdraw", style: buttonTextStyle),
                onPressed: () {},
              )),
          Padding(
              padding: const EdgeInsets.all(12),
              child: ElevatedButton(
                style: buttonStyle,
                child: Text("Deposit", style: buttonTextStyle),
                onPressed: () {},
              )),
          Padding(
              padding: const EdgeInsets.all(12),
              child: ElevatedButton(
                style: buttonStyle,
                child: Text("Leave", style: buttonTextStyle),
                onPressed: () {
                  Navigator.pop(context);
                },
              ))
        ])));
  }
}
