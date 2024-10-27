import 'dart:developer';

import 'package:expense_tracker/res/app_colors.dart';
import 'package:expense_tracker/widgets/flutter_pin_code_widget.dart';
import 'package:flutter/material.dart';

import '../../helper/shared_pref_helper.dart';

class SetupPinScreen extends StatefulWidget {
  const SetupPinScreen({super.key});

  @override
  State<SetupPinScreen> createState() => _SetupPinScreenState();
}

class _SetupPinScreenState extends State<SetupPinScreen> {
  bool reEnterPin = false;
  String _pin = '';

  @override
  Widget build(BuildContext context) {
    var firstTimeEnter = ModalRoute.of(context)!.settings.arguments ?? false;
    return Scaffold(
      backgroundColor: AppColors.buttonColor,
      body: PinCodeWidget(
        reEnterPin: reEnterPin,
        firstEnterInApp: firstTimeEnter == true ? true : false,
        onFullPin: (pin, __) {
          if (firstTimeEnter != true) {
            if (pin == SharedPreferencesConst.getsAppPin()) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                "/dashBoard",
                (route) => false,
              );
              log("Pin -> ");
            }
          } else {
            if (reEnterPin) {
              if (pin == _pin) {
                Navigator.pushNamed(context, "/setUpAccount");
                log("Pin -> ");
                SharedPreferencesConst.setAppPin(pin);
              } else {
                reEnterPin = false;
              }
            } else {
              setState(() {
                reEnterPin = true;
                _pin = pin;
              });
            }
          }
        },
        initialPinLength: 4,
        onChangedPin: (_) {},
      ),
    );
  }
}
