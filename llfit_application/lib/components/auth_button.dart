import 'package:flutter/material.dart';
import 'package:llfit_application/utils/config.dart';

class AuthButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback buttonAction;

  const AuthButton({
    super.key,
    required this.buttonText,
    required this.buttonAction
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 85,
      width: 200,
      child: ElevatedButton(
        onPressed: () {
          buttonAction();
        },
        child: Text(buttonText, style: const TextStyle(color: baseColor, fontSize: 25, fontWeight: FontWeight.w700))
      )
    );
  }
}
