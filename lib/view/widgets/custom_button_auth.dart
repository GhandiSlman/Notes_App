import 'package:flutter/material.dart';

class CustomButtonAuth extends StatelessWidget {
  final void Function()? onPressed;
  final String title;
  const CustomButtonAuth({super.key, this.onPressed, required this.title});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: 40,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: Color.fromARGB(255, 87, 173, 244),
      textColor: Colors.white,
      onPressed: onPressed,
      child: Text(title),
    );
  }
}