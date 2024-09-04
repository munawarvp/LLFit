import 'package:flutter/material.dart';

class TextContainer extends StatelessWidget {
  final String label;
  // final TextEditingController controller;
  final String? defaultValue;

  const TextContainer({
    super.key,
    required this.label,
    // required this.controller,
    this.defaultValue
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label),
          TextFormField(
            // controller: controller,
            initialValue: defaultValue,
            decoration: InputDecoration(
              labelText: label,
              filled: true,
              border: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
