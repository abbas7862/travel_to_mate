import 'package:flutter/material.dart';

class CustomTextFeild extends StatelessWidget {
  final void Function(String)? onChanged;

  final TextEditingController? controller;
  final String hintText;
  const CustomTextFeild({
    this.onChanged,
    this.controller,
    required this.hintText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.050,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        border: Border.all(
          color: Colors.black38,
        ),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: TextField(
            onChanged: onChanged,
            controller: controller,
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 14),
              hintText: hintText,
              hintStyle: TextStyle(color: Colors.black54, fontSize: 11),
            ),
          ),
        ),
      ),
    );
  }
}
