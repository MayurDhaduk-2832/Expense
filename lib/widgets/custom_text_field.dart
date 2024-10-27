import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../Utils/size_utils.dart';
import '../res/strings.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool? obscureText;
  final VoidCallback? onTap;
  final String? Function(String?)? validator;

  CustomTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      this.obscureText,
      this.validator,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      cursorColor: Colors.black,
      style: TextStyle(fontSize: SizeUtil.f13, fontWeight: FontWeight.w500),
      validator: validator,
      obscureText: obscureText ?? false,
      decoration: InputDecoration(
          suffixIcon: obscureText == null
              ? null
              : GestureDetector(
                  onTap: onTap,
                  child: Container(
                    color: Colors.transparent,
                    padding: const EdgeInsets.only(top: 8, bottom: 8, right: 8),
                    child: Image.asset(StringRes.obsecureIcon, height: 5),
                  ),
                ),
          hintText: hintText,
          hintStyle: TextStyle(
              color: const Color(0xFF91919F),
              fontWeight: FontWeight.w400,
              fontSize: SizeUtil.f13),
          contentPadding: obscureText == null
              ? EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h)
              : EdgeInsets.only(
                  left: 5.w, top: 2.2.h, bottom: 2.2.h, right: 1.w),
          enabledBorder: border,
          border: border,
          disabledBorder: border,
          errorBorder: border,
          focusedBorder: border,
          focusedErrorBorder: border),
    );
  }

  final OutlineInputBorder border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide:
        const BorderSide(width: 1, color: Color.fromRGBO(241, 241, 250, 1)),
  );
}
