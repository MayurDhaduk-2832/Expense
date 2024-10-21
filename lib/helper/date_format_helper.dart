import 'package:intl/intl.dart';

class DateFormatHelper {
  static String dateFormat(int date) {
    DateTime now = DateTime.now();
    DateTime newDate = DateTime.fromMicrosecondsSinceEpoch(date);
    DateFormat('hh:mm a').format(DateTime.now());

     return now.difference(newDate).inHours < 24 && now.day == newDate.day  ?
     DateFormat('hh:mm a').format(newDate) :
     DateFormat('dd MMM').format(newDate);
  }

  static bool isToday(int date) {
    DateTime now = DateTime.now();
    DateTime newDate = DateTime.fromMicrosecondsSinceEpoch(date);
    return now.difference(newDate).inHours < 24 ?
     true :
     false;
  }

  static bool isMonth(int date) {
    DateTime now = DateTime.now();
    DateTime newDate = DateTime.fromMicrosecondsSinceEpoch(date);
    if(newDate.year == now.year && newDate.month == now.month){
      return true;
    } else{
      return false;
    }
  }
}