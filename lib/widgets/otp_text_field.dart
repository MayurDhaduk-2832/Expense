import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';


class OtpTextField extends StatefulWidget {
  final TextEditingController controller;
  const OtpTextField({Key? key,required this.controller}) : super(key: key);

  @override
  State<OtpTextField> createState() => _OtpTextFieldState();
}

class _OtpTextFieldState extends State<OtpTextField> {
  int length = 0;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: 234,
          child: PinCodeTextField(
            autoFocus: false,
            appContext: context,
            length: 6,
            obscureText: false,
            obscuringCharacter: '*',
            animationType: AnimationType.none,
            validator: (v) {
              // if (v!.length < 3) {
              //   return "I'm from validator";
              // } else {
              //   return null;
              // }
            },
            pinTheme: PinTheme(
              shape: PinCodeFieldShape.underline,
              activeColor: Colors.white,
              disabledColor: Colors.white,
              errorBorderColor: Colors.white,
              inactiveColor: Colors.white,
              selectedColor: Colors.white,
              inactiveFillColor: Colors.white,
              selectedFillColor: Colors.white,
              borderRadius: BorderRadius.circular(5),
              fieldHeight: 39,
              fieldWidth: 39,
              activeFillColor:
              Colors.white,
            ),
            cursorHeight: 0,
            cursorColor: Colors.black,
            animationDuration: Duration(milliseconds: 300),
            textStyle: TextStyle(fontSize: 20, height: 1.6,color: Colors.black),
            backgroundColor: Colors.white,
            enableActiveFill: true,
            controller: TextEditingController(),
            keyboardType: TextInputType.number,

            onCompleted: (v) {
              print("Completed");
            },
            onChanged: (value) {
              print(value);
              setState((){
              length = value.length;
              });

            },
            beforeTextPaste: (text) {
              print("Allowing to paste $text");
              return true;
            },
          ),
        ),
        SizedBox(
          width: 234,
          height: 42,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              length >= 1 ? _dotNone() : _dot(),
              length >= 2 ? _dotNone() : _dot(),
              length >= 3 ? _dotNone() : _dot(),
              length >= 4 ? _dotNone() : _dot(),
              length >= 5 ? _dotNone() : _dot(),
              length >= 6 ? _dotNone() : _dot(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _dotNone() {
    return const SizedBox(height: 16,width: 16,);
  }

  Widget _dot() {
    return Container(
      width: 16,
      height: 16,
      decoration: const BoxDecoration(color: Color(0xFFE0E2E9),shape: BoxShape.circle),
    );
  }
}
