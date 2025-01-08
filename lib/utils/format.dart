import 'package:intl/intl.dart';

String formatCurrency(String value) {
  try {
    double price = double.parse(value);
    return NumberFormat.currency(locale: 'id', symbol: 'Rp', decimalDigits: 0).format(price);
  } catch (e) {
    return value;
  }
}
String formatTanggal(DateTime tanggal) {
  return DateFormat('dd-MM-yyyy').format(tanggal);
}