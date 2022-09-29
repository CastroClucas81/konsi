import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final TextInputAction textInputAction;
  final int? maxLength;
  final Widget? prefixIcon;
  final void Function()? onEditingComplete;

  const CustomInput({
    Key? key,
    required this.controller,
    required this.hintText,
    this.onChanged,
    this.validator,
    this.textInputAction = TextInputAction.done,
    this.maxLength,
    this.prefixIcon,
    this.onEditingComplete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: TextFormField(
        maxLength: maxLength ?? null,
        controller: controller,
        textInputAction: textInputAction,
        onEditingComplete: onEditingComplete,
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          hintText: hintText,
          border: OutlineInputBorder(),
          filled: true,
        ),
        onChanged: onChanged,
        validator: validator,
      ),
    );
  }
}
