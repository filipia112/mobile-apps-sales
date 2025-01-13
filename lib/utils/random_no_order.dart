import 'dart:math';

import 'package:apps_sales/utils/shared_preferences.dart';
import 'package:intl/intl.dart';

class RandomNoOrder {
  static Future<String> generateRandomStringFromDateAndUserId() async {
    final String? userId = await SharedPrefHelper.getUserId();
    DateTime now = DateTime.now();
    String year = DateFormat('yyyy').format(now);
    String month = DateFormat('MM').format(now);
    String day = DateFormat('dd').format(now);
    String hour = DateFormat('HH').format(now);
    String minute = DateFormat('mm').format(now);
    String second = DateFormat('ss').format(now);
    String randomString = '$year$month$day$hour$minute$second$userId';
    String randomSuffix = _generateRandomString(4);

    return randomString + randomSuffix;
  }
  static String _generateRandomString(int length) {
    const _chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    Random _rnd = Random();
    return String.fromCharCodes(Iterable.generate(length, (_) {
      return _chars.codeUnitAt(_rnd.nextInt(_chars.length));
    }));
  }
}