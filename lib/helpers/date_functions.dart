import 'package:intl/intl.dart';

String getTodayDate() {
  DateTime now = DateTime.now();
  String formattedDate = DateFormat('dd-MM-yyyy').format(now);
  return formattedDate;
}

String formatDateTime(String dateTime) {
  DateTime parsedDate = DateTime.parse(dateTime);
  return DateFormat('ddMMM y').format(parsedDate);
}
String getDayFromDate(String dateTime) {
  DateTime parsedDate = DateTime.parse(dateTime);
  return DateFormat('EEEE').format(parsedDate); // 'EEEE' gives the full day name
}