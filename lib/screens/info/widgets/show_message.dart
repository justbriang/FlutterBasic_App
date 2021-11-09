import 'package:flutter/material.dart';

void showMessage({required String message, required Color color,required BuildContext context}) {
  final snackBar = SnackBar(
    backgroundColor: color,
    content: Text(message),
    action: SnackBarAction(
      label: 'Close',
      onPressed: () {},
    ),
  );

  // Find the ScaffoldMessenger in the widget tree
  // and use it to show a SnackBar.
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
