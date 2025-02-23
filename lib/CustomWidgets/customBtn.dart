import 'package:flutter/material.dart';

class CustomBtn extends StatefulWidget {
  final VoidCallback onTap;
  final String text;
  const CustomBtn({
    required this.onTap,
    required this.text,
    super.key,
  });

  @override
  State<CustomBtn> createState() => _CustomBtnState();
}

class _CustomBtnState extends State<CustomBtn> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onTap,
      child: Text(
        widget.text,
        style: TextStyle(color: Colors.white),
      ),
      style: ButtonStyle(
          padding: MaterialStatePropertyAll(
            EdgeInsets.symmetric(horizontal: 70, vertical: 10),
          ),
          shape: MaterialStatePropertyAll(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7),
          )),
          backgroundColor: MaterialStatePropertyAll(Color(0xFF088F8F))),
    );
  }
}
