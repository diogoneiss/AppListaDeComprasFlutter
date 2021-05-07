import 'package:intl/intl.dart';

String dateFormatter() {
  var now = DateTime.now();
  var formatter = new DateFormat("yyyy-MM-dd hh:mm");
  String formatted = formatter.format(now);
  return formatted;
}
