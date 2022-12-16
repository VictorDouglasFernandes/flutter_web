import 'package:flutter/material.dart';

class ErrorDialog {
  static void show(BuildContext context, Exception error) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(error.toString()),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('OK'),
          )
        ],
      ),
    );
  }
}
