import 'package:flutter/material.dart';

class LoaderDialog {
  //show a loader dialog
  static Future<void> showLoaderDialog(BuildContext context) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () => Future<bool>.value(false),
          child: AlertDialog(
            elevation: 0,
            content: Container(
              padding: EdgeInsets.all(20.0),
              child: SizedBox(
                height: 60,
                width: 60,
                child: Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 4,
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Colors.blueAccent),
                  ),
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
