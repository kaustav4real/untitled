import 'package:intl/intl.dart';

String getTodayDate() {
  DateTime now = DateTime.now();
  String formattedDate = DateFormat('dd-MM-yyyy').format(now);
  return formattedDate;
}

String getDateInYYYYMMDDFromArgument(DateTime dateTime){
  String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
  return formattedDate;
}

String getDateYYYYMMDD(){
  DateTime now = DateTime.now();
  String formattedDate = DateFormat('yyyy-MM-dd').format(now);
  return formattedDate;
}

String formatDateTime(String dateTime) {
  DateTime parsedDate = DateTime.parse(dateTime);
  return DateFormat('dd MMM y').format(parsedDate);
}
String getDayFromDate(String dateTime) {
  DateTime parsedDate = DateTime.parse(dateTime);
  return DateFormat('EEEE').format(parsedDate); // 'EEEE' gives the full day name
}