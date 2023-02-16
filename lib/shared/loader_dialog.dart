import 'package:flutter/material.dart';

class LoaderDialog {
  //show a lodar dialog
  static Future<void> showLoaderDialog(BuildContext context) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () => Future.value(false),
          child: const AlertDialog(
            contentPadding: EdgeInsets.all(8),
            content: SizedBox(
              height: 100,
              width: 100,
              child: Center(
                child: CircularProgressIndicator.adaptive(),
              ),
            ),
          ),
        );
      },
    );
  }
  //hide the loading dialog
  static void hideDialog(BuildContext context) {
    Navigator.of(context).maybePop();
  }
}
