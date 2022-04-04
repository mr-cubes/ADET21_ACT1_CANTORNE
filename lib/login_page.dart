import 'package:atm/card_number.dart';
import 'package:atm/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:atm/bank_service.dart';
import 'package:atm/account.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  BankService bankService = BankService();

  TextEditingController cardNumberController = TextEditingController();
  TextEditingController pinController = TextEditingController();
  late TextFormField cardNumberInput;

  InputDecoration createInputDecoration(String hint, String iconAsset) {
    // function for creating decoration for login text field
    return InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10.0)),
        filled: true,
        fillColor: Colors.black12,
        prefixIcon: Padding(
            padding: const EdgeInsets.all(12),
            child: SvgPicture.asset(iconAsset, color: Colors.black38)),
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.black38, letterSpacing: 1));
  }

  void displayError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message, textAlign: TextAlign.center),
        duration: const Duration(seconds: 1)));
  }

  void submit(BuildContext context) {
    try {
      var cardNumber = CardNumber.parse(cardNumberController.text);
      var pin = pinController.text;
      Account? account = bankService.openAccount(cardNumber, pin);

      if (account == null) {
        displayError(context, "Cannot open account");
        return;
      }

      cardNumberController.text = "";
      pinController.text = "";

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Dashboard(account)),
      );
    } catch (ex) {
      displayError(context, "Invalid card number");
    }
  }

  @override
  Widget build(BuildContext context) {
    cardNumberInput = TextFormField(
        controller: cardNumberController,
        decoration:
            createInputDecoration('Card Number', 'assets/card-number.svg'),
        enableSuggestions: false,
        style: const TextStyle(letterSpacing: 8),
        inputFormatters: [
          LengthLimitingTextInputFormatter(6),
          FilteringTextInputFormatter.allow(RegExp(r'[0-9]{1,6}')),
        ],
        validator: (value) {
          return null;
        });

    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 40, 86, 212),
        body: Center(
            child: FractionallySizedBox(
          widthFactor: 0.25,
          heightFactor: 0.6,
          child: Container(
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 232, 232, 232),
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromARGB(40, 0, 0, 0),
                        spreadRadius: 4,
                        blurRadius: 4,
                        offset: Offset(4, 4))
                  ]),
              child: Form(
                child: Column(
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(20),
                        child: SvgPicture.asset(
                          'assets/bank-flat.svg',
                          width: 128,
                          height: 128,
                        )),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(24, 8, 24, 8),
                        child: cardNumberInput),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 8, 24, 8),
                      child: TextFormField(
                          controller: pinController,
                          decoration:
                              createInputDecoration('PIN', 'assets/pin.svg'),
                          style: const TextStyle(letterSpacing: 8),
                          obscureText: true,
                          enableSuggestions: false,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(6),
                            FilteringTextInputFormatter.allow(
                                RegExp(r'[0-9]{1,6}')),
                          ]),
                    ),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
                        child: ElevatedButton(
                          onPressed: () => submit(context),
                          style: ElevatedButton.styleFrom(
                              minimumSize: const Size.fromHeight(48)),
                          child: const Text("OK"),
                        ))
                  ],
                ),
              )),
        )));
  }
}
