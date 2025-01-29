import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  final String error;
  const ErrorDialog({
    Key? key,
    required this.error,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        height: 350,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              error,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.red,
              ),
            )
          ],
        ),
      ),
    );
  }
}
