import 'package:flutter/material.dart';

class Popup {
  static showAlert(
      {required BuildContext context,
      required String title,
      required String content,
      String? snackBarText,
      required void Function() onConfirm,
      void Function()? onDeny}) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            child: const Text('Abbrechen'),
            onPressed: () {
              if (onDeny != null) onDeny();
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Bestätigen'),
            onPressed: () {
              if (snackBarText != null) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(snackBarText),
                  showCloseIcon: true,
                ));
              }

              onConfirm();

              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
