import 'package:flutter/material.dart';
import 'package:rayatro_cloth2/constans/colors.dart';

class CustomTextFildInUpload extends StatelessWidget {
  final int maxLines;
  final IconData? icon;
  final String hint;
  final double radius;
  final TextInputType keyboardType;
  final Color colors;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  CustomTextFildInUpload({
    Key? key,
    this.maxLines = 1,
    this.icon,
    required this.hint,
    this.radius = 10,
    required this.keyboardType,
    required this.colors,
    required this.controller,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        icon: icon == null ? null : Icon(icon),
        hintText: hint,
        hintStyle: Theme.of(context)
            .textTheme
            .subtitle1!
            .copyWith(color: SecondaryText),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide(color: colors),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide(color: colors),
        ),
      ),
    );
  }
}
