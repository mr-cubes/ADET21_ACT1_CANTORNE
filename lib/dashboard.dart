import 'dart:math';

import 'package:atm/account.dart';
import 'package:atm/bank_service.dart';
import 'package:atm/numerical_range_formatter.dart';
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
                onPressed: () {
                  showWithdrawDialog(context);
                },
              )),
          Padding(
              padding: const EdgeInsets.all(12),
              child: ElevatedButton(
                style: buttonStyle,
                child: Text("Deposit", style: buttonTextStyle),
                onPressed: () {
                  showDepositDialog(context);
                },
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
                                  onPressed: () {
                                    Navigator.pop(context);
                                    showWithdrawDialog(context);
                                  },
                                )),
                            Padding(
                                padding: const EdgeInsets.all(8),
                                child: ElevatedButton(
                                  child: const Text("Deposit"),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    showDepositDialog(context);
                                  },
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

  void showWithdrawDialog(BuildContext context) {
    var amountCountroller = TextEditingController(text: "200.00");
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: SizedBox(
              width: 285,
              height: 210,
              child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                              "Balance PHP ${widget.account.getBalance().toStringAsFixed(2)}",
                              style: const TextStyle(
                                  color: Colors.black87, fontSize: 16),
                              textAlign: TextAlign.center)),
                      Padding(
                          padding: const EdgeInsets.all(8),
                          child: SizedBox(
                              width: 200,
                              child: TextFormField(
                                  controller: amountCountroller,
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  inputFormatters: [
                                    NumericalRangeFormatter(
                                        200,
                                        min(widget.account.getBalance(), 30000),
                                        100)
                                  ],
                                  decoration: const InputDecoration(
                                      label: Text("Amount",
                                          textAlign: TextAlign.center),
                                      hintText: "Enter amount")))),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                                padding: const EdgeInsets.all(12),
                                child: ElevatedButton(
                                  child: const Text("Cancel"),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                )),
                            Padding(
                                padding: const EdgeInsets.all(12),
                                child: ElevatedButton(
                                  child: const Text("OK"),
                                  onPressed: () {
                                    widget.account.withdraw(
                                        double.parse(amountCountroller.text));
                                    BankService.getService().saveState();

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

  void showDepositDialog(BuildContext context) {
    var amountCountroller = TextEditingController(text: "200.00");
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: SizedBox(
              width: 285,
              height: 210,
              child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                              "Balance PHP ${widget.account.getBalance().toStringAsFixed(2)}",
                              style: const TextStyle(
                                  color: Colors.black87, fontSize: 16),
                              textAlign: TextAlign.center)),
                      Padding(
                          padding: const EdgeInsets.all(8),
                          child: SizedBox(
                              width: 200,
                              child: TextFormField(
                                  controller: amountCountroller,
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  inputFormatters: [
                                    NumericalRangeFormatter(200, 30000, 100)
                                  ],
                                  decoration: const InputDecoration(
                                      label: Text("Amount",
                                          textAlign: TextAlign.center),
                                      hintText: "Enter amount")))),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                                padding: const EdgeInsets.all(12),
                                child: ElevatedButton(
                                  child: const Text("Cancel"),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                )),
                            Padding(
                                padding: const EdgeInsets.all(12),
                                child: ElevatedButton(
                                  child: const Text("OK"),
                                  onPressed: () {
                                    widget.account.deposit(
                                        double.parse(amountCountroller.text));
                                    BankService.getService().saveState();

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
