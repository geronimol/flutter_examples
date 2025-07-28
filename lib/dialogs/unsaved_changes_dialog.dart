import 'package:flutter/material.dart';

import '../constants.dart';

class UnsavedChangesDialog {
  static dynamic show() async {
    return await showGeneralDialog(
      barrierDismissible: false,
      transitionDuration: const Duration(milliseconds: 300),
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position: Tween(begin: const Offset(0, 1), end: const Offset(0, 0)).animate(anim1),
          child: child,
        );
      },
      context: navigatorKey.currentContext!,
      pageBuilder: (context, anim1, anim2) {
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
          child: Container(
            width: 400,
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Unsaved Changes',
                  style: kHeader1TextStyle,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 29),
                const Text(
                  'Are you sure you want to discard the current changes?',
                  style: TextStyle(fontSize: 15),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 29),
                SizedBox(
                  height: 35,
                  width: 130,
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: const Text(
                      'YES',
                      style: kButtonTextStyle,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 35,
                  width: 130,
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text(
                      'CANCEL',
                      style: kButtonTextStyle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}