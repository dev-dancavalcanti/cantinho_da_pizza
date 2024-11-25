import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String text;
  final bool? add;
  final VoidCallback? function;
  const CustomTextField(
      {super.key,
      required this.controller,
      this.add = false,
      this.function,
      required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      child: TextField(
        inputFormatters: [],
        autofocus: false,
        decoration: InputDecoration(
          suffixIconColor: Colors.red,
          labelText: text,
          contentPadding: const EdgeInsets.only(left: 15),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(
                color: Colors.white, style: BorderStyle.solid, width: 5),
          ),
          suffixIcon: add!
              ? IconButton(
                  onPressed: add! ? function : null,
                  icon: const Icon(Icons.add))
              : null,
        ),
        controller: controller,
      ),
    );
  }
}
