import 'package:flutter/material.dart';

Future<void> showExitDialog(BuildContext context, Function exitApp) async {
  await showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Menutup Aplikasi...'),
        content: const Text('Keluar dari aplikasi?'),
        actions: <Widget>[
          TextButton(
            child: const Text('Tidak'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Ya'),
            onPressed: () {
              Navigator.of(context).pop();
              // Exit the app
              exitApp();
            },
          ),
        ],
      );
    },
  );
}