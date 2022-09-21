import 'package:flutter/material.dart';

Future<void> dialog({
  required BuildContext context,
  required String title,
  required String description,
  required List<Widget> actions,
}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(description),
        actions: actions,
      );
    },
  );
}
