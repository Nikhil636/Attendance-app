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
            elevation: 0,
            content: SizedBox(
              height: 60,
              width: 60,
              child: Center(
                child: CircularProgressIndicator.adaptive(
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Color.fromRGBO(2, 64, 116, 1)),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  //hide the loading dialog
  static void hideDialog(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.of(context).pop();
    }
  }
}
