import 'package:intl/intl.dart';

///A helper function that takes a date parameter and an optional pattern parameter.
///If the date is null the fucntion returns null, and if the pattern is null the
///function defaults to `dd/MM/yyyy`
String getStrDate(DateTime date, {String pattern}) {
  DateFormat defaultFormat = DateFormat('dd/MM/yyyy');

  if (date == null || date.millisecondsSinceEpoch == 0) {
    return null;
  }

  DateFormat format;
  if (pattern != null) {
    try {
      format = DateFormat(pattern);
    } on Exception catch (e) {
      throw ('errorDatePattern: $e');
    }
  }

  String formattedDate;
  if (format != null) {
    formattedDate = format.format(date);
  } else {
    formattedDate = defaultFormat.format(date);
  }

  return formattedDate;
}
