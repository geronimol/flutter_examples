import 'package:flutter/material.dart';

import '../../../models/account.dart';

class ConfirmationDialog {
  static dynamic show(BuildContext context, {required List<Account> accountsList}) {
    return showGeneralDialog(
      barrierDismissible: true,
      barrierLabel: '',
      transitionDuration: const Duration(milliseconds: 300),
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position: Tween(begin: const Offset(0, 1), end: const Offset(0, 0)).animate(anim1),
          child: child,
        );
      },
      context: context,
      pageBuilder: (context, anim1, anim2) {
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 20),
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
          child: Container(
            width: 600,
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 5),
                const Text('Thanks!', style: TextStyle(color: Colors.black87, fontSize: 25, fontWeight: FontWeight.w900)),
                const SizedBox(height: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (accountsList.isEmpty) ...[
                      Text('No accounts added!')
                    ] else ...[
                      Text('Accounts'),
                      ...accountsList.map((e) => Text(e.email, style: const TextStyle(color: Colors.black54, fontSize: 16))),
                    ],
                  ],
                ),
                const SizedBox(height: 12),
                ElevatedButton(onPressed: () => Navigator.of(context).pop(), child: Text('OK')),
              ],
            ),
          ),
        );
      },
    );
  }
}
