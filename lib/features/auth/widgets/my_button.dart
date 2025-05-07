import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String buttonText;
  final Color buttonTextColor;
  final Color buttonBgColor;
  final Function()? onTap;


  const MyButton({
    super.key,
    required this.buttonText,
    required this.buttonTextColor,
    required this.buttonBgColor,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const  EdgeInsets.all(25),
        margin: const EdgeInsets.symmetric(horizontal:25),
        decoration: BoxDecoration(
          color: buttonBgColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            buttonText,
            style: TextStyle(
              color: buttonTextColor,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        
      ),
    );
  }
}
