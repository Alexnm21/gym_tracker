import 'package:flutter/material.dart';
import 'package:gym_tracker/config/app_theme.dart';

class GradientButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final LinearGradient gradient;

  const GradientButton({super.key, 
    required this.onPressed,
    required this.text,
    required this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      radius: 30,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          text,
          style: AppTheme.h3Normal.copyWith(color: Colors.white)
        ),
      ),
    );
  }
}