class DateString {
  static String dateToString(DateTime date) {
    String dt = date.toString().split(" ")[0];
    var dateNew = dt.split('-');
    // yyyymmdd -> ddmmyyyy
    return '${dateNew[2]}-${dateNew[1]}-${dateNew[0]}';
  }

  static DateTime stringToDateTime(String date) {
    var dateNew = date.split('-');
    return DateTime.parse('${dateNew[2]}${dateNew[1]}${dateNew[0]}');
  }

  static String dateFormatChange(String date) {
    var dateNew = date.split('-');
    // yyyymmdd -> ddmmyyyy or ddmmyyyy -> yyyymmdd
    return '${dateNew[2]}-${dateNew[1]}-${dateNew[0]}';
  }

  static int compareDate(String a, String b) {
    String d1 = DateString.dateFormatChange(a.toString());
    String d2 = DateString.dateFormatChange(b.toString());
    return d1.compareTo(d2);
  }

  static List<String> sortDateList(List<String> dateList) {
    dateList.sort((a, b) => DateString.compareDate(a, b));
    return dateList;
  }
}
