import 'package:flutter/material.dart';

void showCustomSnackBar(BuildContext context, String message) {
  final snackBar = SnackBar(
    content: Text(message),
    duration: const Duration(seconds: 3), // Adjust the duration as per your requirement
    action: SnackBarAction(
      label: 'Close',
      onPressed: () {
        // Some code to be executed when the SnackBar action button is pressed
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
      },
    ),
  );

  // Display the snackbar
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
