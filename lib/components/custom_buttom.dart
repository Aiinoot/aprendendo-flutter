import 'package:flutter/material.dart';

class CustomButtom extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;

  const CustomButtom({
    super.key,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          textStyle: const TextStyle(fontSize: 18),
          minimumSize: const Size(300, 50)),
      child: Text(buttonText),
    );
  }
}
