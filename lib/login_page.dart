import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 40, 86, 212),
        body: Center(
            child: FractionallySizedBox(
          widthFactor: 0.3,
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
                  children: [],
                ),
              )),
        )));
  }
}
