import 'package:intl/intl.dart';

class NumberFormatter {

  static String formatInt (int number) {
    final formatter = NumberFormat('#,###,##0');
    return formatter.format(number);
  }

  static String formatDouble (double number) {
    final formatter = NumberFormat('#,###,##0.00');
    return formatter.format(number);
  }
}