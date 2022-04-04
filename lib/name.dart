import 'package:flutter/material.dart';

class Name {
  final String firstName;
  final String middleName;
  final String lastName;
  final String extendedName;
  late final String middleInitial;

  Name(this.firstName, this.middleName, this.lastName, this.extendedName) {
    _setMiddleInitials();
  }

  void _setMiddleInitials() {
    var buffer = StringBuffer();
    var uppercase = middleName.toUpperCase();

    for (var i = 0; i < middleName.length; i++) {
      if (uppercase[i] == middleName[i]) {
        buffer.write("${uppercase[i]}.");
      }
    }

    middleInitial = buffer.toString();
  }

  String toProperName() {
    return "$firstName $middleInitial $lastName";
  }
}
