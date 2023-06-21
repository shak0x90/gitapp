import 'package:intl/intl.dart';

class Utils {
  /// use to format date time.
  static String formatDateTime(String? inputDateTime) {
    DateTime dateTime2 = DateTime.parse(inputDateTime!);
    String dateString = DateFormat('MMMM d, yyyy').format(dateTime2);
    return dateString;
  }
}
