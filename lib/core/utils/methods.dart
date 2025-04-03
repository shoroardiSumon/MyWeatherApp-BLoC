import 'package:intl/intl.dart';

String formatDate(int timestamp) {
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000, isUtc: true);
  return DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);
}