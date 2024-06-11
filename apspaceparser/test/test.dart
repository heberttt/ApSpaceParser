import 'dart:io';
import '../lib/classes.dart';

String getPath() {
  String path = Directory.current.path;
  List<String> pathArr = path.split("\\");
  String result = "";
  for (int i = 0; i < pathArr.length; i++) {
    result += pathArr[i];
    result += "/";
  }

  result += "technicalAssistantsIntake.json";

  return result;
}

Date getThisWeekDateTEST() {
  DateTime today = DateTime.now();
  int currentDay = today.weekday;

  Date date = Date(m: today.month, d: today.day, y: today.year);

  //date.minDate(currentDay - 1);
  date.minDate(1);

  return date;
}

void main() {
  print(getPath());
  DateTime today = DateTime.now();
  int currentDay = today.weekday;
  print(currentDay);
  print(today.day);
  Date d = getThisWeekDateTEST();
  print(d);
}
