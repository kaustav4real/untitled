import 'package:intl/intl.dart';

String getTodayDate() {
  DateTime now = DateTime.now();
  String formattedDate = DateFormat('dd-MM-yyyy').format(now);
  return formattedDate;
}

String formatDateTime(DateTime dateTime) {
  return DateFormat('ddMMM y').format(dateTime);
}

String getDayFromDate(DateTime dateTime) {
  return DateFormat('EEEE').format(dateTime); // 'EEEE' gives the full day name
}