import 'package:flutter/material.dart';

class InputForm extends StatelessWidget {
  final TextEditingController controller;
  final String? label;
  final Icon? icon;
  final int? maxLine;
  final String? hintText;
  const InputForm({
    super.key,
    required this.controller,
    this.label,
    this.icon,
    this.maxLine,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLine,
      
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: icon,
        fillColor: Color(0xff000EA7),
        border:  OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        label: Text(label ?? ""),
      ),
      controller: controller,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Campo obrigatório";
        }
        return null;
      },
    );
  }
}
