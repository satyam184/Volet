import 'package:flutter/material.dart';
import 'package:wallet/utils/screen_util.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.onChanged,
    this.icon,
    this.obsecure = false,
    this.validator,
  });
  final void Function(String) onChanged;
  final Icon? icon;
  final bool obsecure;
  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: ScreenUtil.width(5)),
      width: ScreenUtil.width(90),
      child: TextFormField(
        validator: validator,
        obscuringCharacter: '*',
        obscureText: obsecure,
        onChanged: onChanged,
        cursorColor: Color(0xFFd5d5de),
        decoration: InputDecoration(
          suffixIcon: icon,
          suffixIconColor: Colors.black,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Color(0xFFd5d5de), width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Color(0xFFd5d5de), width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Color(0xFFd5d5de), width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.red, width: 2),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.red, width: 2),
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 14,
            horizontal: 18,
          ),
        ),
      ),
    );
  }
}
