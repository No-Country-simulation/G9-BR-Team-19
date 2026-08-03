import 'package:flutter/material.dart';

class InputForm extends StatelessWidget {
  final TextEditingController controller;
  final String? label;
  final Icon? icon;
  final int? maxLine;
  final String? hintText;
  final bool obscureText;
  const InputForm({
    super.key,
    required this.controller,
    this.label,
    this.icon,
    this.maxLine,
    this.hintText,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: true,
      maxLines: obscureText == true ? 1 : maxLine,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: icon,
        fillColor: Color(0xff000EA7),
        enabledBorder: bordeSide(Colors.white),
        focusedBorder: bordeSide(Colors.white),
        errorBorder: bordeSide(Colors.red),
        focusedErrorBorder: bordeSide(Colors.red),
        // border: OutlineInputBorder(
        //   borderSide: BorderSide(color: Colors.white),
        //   borderRadius: BorderRadius.circular(12),
        // ),
        label: Text(
          label ?? "",
          style: TextStyle(color: const Color.fromARGB(169, 255, 255, 255)),
        ),
      ),
      controller: controller,
      style: const TextStyle(color: Colors.white),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Campo obrigatório";
        }
        return null;
      },
    );
  }

  OutlineInputBorder bordeSide(Color color) {
    return OutlineInputBorder(
      borderSide: BorderSide(color: color),
      borderRadius: BorderRadius.circular(12),
    );
  }
}
