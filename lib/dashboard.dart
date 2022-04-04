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
                onPressed: () {
                  showCheckBalanceDialog(context);
                },
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

  void showCheckBalanceDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: SizedBox(
              width: 360,
              height: 180,
              child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                          padding: const EdgeInsets.all(12),
                          child: Text(
                              "Your Balance is PHP ${widget.account.getBalance().toStringAsFixed(2)}",
                              style: const TextStyle(
                                  color: Colors.black87, fontSize: 16),
                              textAlign: TextAlign.center)),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                                padding: const EdgeInsets.all(12),
                                child: ElevatedButton(
                                  child: const Text("Withdraw"),
                                  onPressed: () {},
                                )),
                            Padding(
                                padding: const EdgeInsets.all(8),
                                child: ElevatedButton(
                                  child: const Text("Deposit"),
                                  onPressed: () {},
                                )),
                            Padding(
                                padding: const EdgeInsets.all(12),
                                child: ElevatedButton(
                                  child: const Text("Go back"),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ))
                          ])
                    ],
                  )),
            ),
          );
        });
  }
}
