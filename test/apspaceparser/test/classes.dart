import 'package:stack_trace/stack_trace.dart';
import 'dart:io';
import 'dart:convert';

class Day {
  List<int> startTime = [];
  List<int> endTime = [];
  Date date;
  List<dynamic> todaySchedule = [];

  Day(this.date, this.todaySchedule) {
    // immideatly put to todaySchedule
    getStartAndEndTime();
  }

  void getStartAndEndTime() {
    for (var i in todaySchedule) {
      Time s = Time(i['TIME_FROM']);
      Time e = Time(i['TIME_TO']);
      startTime.add(s.getTime());
      endTime.add(e.getTime());
    }
  }
}

class Week {
  late Day monday;
  late Day tuesday;
  late Day wednesday;
  late Day thursday;
  late Day friday;

  Week(Date start, List<dynamic> data, String intake, String? special) {
    if (special == "hebert") {
      monday =
          Day(start, getOneDaySchedule(getHebertData(data, intake), start));
      start.addDate(1);
      tuesday =
          Day(start, getOneDaySchedule(getHebertData(data, intake), start));
      start.addDate(1);
      wednesday =
          Day(start, getOneDaySchedule(getHebertData(data, intake), start));
      start.addDate(1);
      thursday =
          Day(start, getOneDaySchedule(getHebertData(data, intake), start));
      start.addDate(1);
      friday =
          Day(start, getOneDaySchedule(getHebertData(data, intake), start));
    } else {
      monday =
          Day(start, getOneDaySchedule(getIntakeData(data, intake), start));
      start.addDate(1);
      tuesday =
          Day(start, getOneDaySchedule(getIntakeData(data, intake), start));
      start.addDate(1);
      wednesday =
          Day(start, getOneDaySchedule(getIntakeData(data, intake), start));
      start.addDate(1);
      thursday =
          Day(start, getOneDaySchedule(getIntakeData(data, intake), start));
      start.addDate(1);
      friday =
          Day(start, getOneDaySchedule(getIntakeData(data, intake), start));
    }


    
  }

  Week.withGroup(Date start, List<dynamic> data, String intake, String? special, String group) {
    monday =
        Day(start, getOneDaySchedule(getIntakeWithGroupData(data, intake, group), start));
        start.addDate(1);
    tuesday =
        Day(start, getOneDaySchedule(getIntakeWithGroupData(data, intake, group), start));
        start.addDate(1);
    wednesday =
        Day(start, getOneDaySchedule(getIntakeWithGroupData(data, intake, group), start));
        start.addDate(1);
    thursday =
        Day(start, getOneDaySchedule(getIntakeWithGroupData(data, intake, group), start));
        start.addDate(1);
    friday =
        Day(start, getOneDaySchedule(getIntakeWithGroupData(data, intake, group), start));
  }

  void printSchedule() {
    print(monday.startTime);
    print((monday).endTime);
    print((tuesday).startTime);
    print((tuesday).endTime);
    print((wednesday).startTime);
    print((wednesday).endTime);
    print((thursday).startTime);
    print((thursday).endTime);
    print((friday).startTime);
    print((friday).endTime);
    print("-----------------------------------------");
  }
}

class Time {
  int hour = 0;
  int minute = 0;

  Time(String t) {
    List<String> timeSplit = t.split(" ");
    List<String> timeSplitSplit = timeSplit[0].split(":");
    hour = int.parse(timeSplitSplit[0]);
    minute = int.parse(timeSplitSplit[1]);
    if (timeSplit[1] == "PM") {
      hour += 12;
      if (hour > 23) {
        hour -= 12;
      }
    }
  }
  int getTime() {
    String result = "$hour$minute";
    if (minute == 0) {
      result = "${hour}00";
    }
    return int.parse(result);
  }
}

class Date {
  int month = 0;
  int date = 0;
  int year = 0;

  Date({m, d, y}) {
    month = m;
    date = d;
    year = y;
  }

  void addDate(int days) {
    date += days;
    if (date > maxDate()) {
      date -= maxDate();
      addMonth(1);
    }
  }

  void addMonth(int i) {
    month += i;
    if (month > 12) {
      month -= 12;
      year++;
    }
  }

  void minDate(int days) {
    date -= days;
    if (date < 1) {
      date += maxDate();
      minMonth(1);
    }
  }

  void minMonth(int i) {
    month -= i;
    if (month < 1) {
      month += 12;
      year--;
    }
  }

  int maxDate() {
    if (month == 2) {
      if (year % 4 == 0) {
        return 29;
      } else {
        return 28;
      }
    } else if (month < 8 && month % 2 == 0) {
      return 30;
    } else if (month >= 8 && month % 2 == 1) {
      return 30;
    } else {
      return 31;
    }
  }

  bool compareDate(String m) {
    List<String> ymdMB = m.split("-");
    List<String> ymdTB = [year.toString(), month.toString(), date.toString()];
    List<int> ymdM = [
      int.parse(ymdMB[0]),
      int.parse(ymdMB[1]),
      int.parse(ymdMB[2])
    ];
    List<int> ymdT = [
      int.parse(ymdTB[0]),
      int.parse(ymdTB[1]),
      int.parse(ymdTB[2])
    ];

    if (ymdM[0] < ymdT[0]) {
      return true;
    } else if (ymdM[0] == ymdT[0]) {
      if (ymdM[1] < ymdT[1]) {
        return true;
      } else if (ymdM[1] == ymdT[1]) {
        if (ymdM[2] < ymdT[2]) {
          return true;
        } else if (ymdM[2] == ymdT[0]) {
          return false; // if both days are mondays, it will not accept (change when needed)
        } else {
          return false;
        }
      } else {
        return false;
      }
    } else {
      return false;
    }
  }
}

List<dynamic> getIntakeData(List<dynamic> data, String intake) {
  List<dynamic>? filteredData = [];

  for (var i in data) {
    if (i['INTAKE'] == intake) {
      filteredData.add(i);
    }
  }

  return filteredData;
}

List<dynamic> getIntakeWithGroupData(
    List<dynamic> data, String intake, String group) {
  List<dynamic>? filteredData = [];

  for (var i in data) {
    if (i['INTAKE'] == intake && i['GROUPING'] == group) {
      filteredData.add(i);
    }
  }

  return filteredData;
}

List<dynamic> getHebertData(List<dynamic> data, String intake) {
  List<dynamic>? filteredData = [];

  for (var i in data) {
    if (i['INTAKE'] == intake &&
        i['MODID'] != "CT074-3-2-CCP-L-1" &&
        i['MODID'] != "CT117-3-2-FWDD-LAB1" &&
        i['MODID'] != "CT074-3-2-CCP-LAB-1" &&
        i['MODID'] != "MPU3412-CC2-L-1 (Online)" &&
        i['MODID'] != "CT117-3-2-FWDD-L-1") {
      filteredData.add(i);
    }
  }

  return filteredData;
}

Date getThisWeekDate() {
  DateTime today = DateTime.now();
  int currentDay = today.weekday;

  Date date = Date(m: today.month, d: today.day, y: today.year);

  date.minDate(currentDay - 1);

  return date;
}

int getNumberOfWeeks(List<dynamic> data) {
  Date nextMon = getThisWeekDate();
  nextMon.addDate(7);
  var lastIndex = data[data.length - 1];
  String lastDate = lastIndex['DATESTAMP_ISO'];

  if (!nextMon.compareDate(lastDate)) {
    nextMon.addDate(7);
    if (!nextMon.compareDate(lastDate)) {
      nextMon.addDate(7);
      if (!nextMon.compareDate(lastDate)) {
        return 3;
      }
      return 2;
    }
    return 1;
  }

  return 1;
}

List<dynamic> getOneDaySchedule(List<dynamic> schedule, Date today) {
  String todayStr = "${today.year}-${today.month}-${today.date}";
  List<dynamic> todaySchedule = [];

  for (var i in schedule) {
    String a = i['DATESTAMP_ISO'];
    List<String> asplit = a.split("-");
    Date formattedDate = Date(
        y: int.parse(asplit[0]),
        m: int.parse(asplit[1]),
        d: int.parse(asplit[2]));
    String f =
        "${formattedDate.year}-${formattedDate.month}-${formattedDate.date}";
    if (f == todayStr) {
      todaySchedule.add(i);
    }
  }

  return todaySchedule;
}

List<int> getDesperateAvailableShifts(Day d) {
  List<int> startShift = [
    815,
    1030,
    1130,
    1230,
    1330,
    1430,
    1530,
    1630,
    1730,
    1900
  ];
  List<int> endShift = [
    1030,
    1130,
    1230,
    1330,
    1430,
    1530,
    1630,
    1730,
    1900,
    2130
  ];

  List<int> availableShifts = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

  for (int i = 0; i < d.startTime.length; i++) {
    for (int j = 0; j < startShift.length; j++) {
      if (d.startTime[i] <= startShift[j] && startShift[j] < d.endTime[i]) {
        availableShifts[j] = -1;
      } else if (d.startTime[i] < endShift[j] && endShift[j] <= d.endTime[i]) {
        // if the class ends when the shift starts, the shift is not included
        availableShifts[j] = 0;
      } else if (d.startTime[i] >= startShift[j] &&
          d.endTime[i] <= endShift[j]) {
        availableShifts[j] = -2;
      }
    }
  }

  return availableShifts;
}

List<int> getAvailableShifts(Day d) {
  List<int> startShift = [
    830,
    1030,
    1130,
    1230,
    1330,
    1430,
    1530,
    1630,
    1730,
    1900
  ];
  List<int> endShift = [
    1030,
    1130,
    1230,
    1330,
    1430,
    1530,
    1630,
    1730,
    1900,
    2130
  ];

  List<int> availableShifts = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

  for (int i = 0; i < d.startTime.length; i++) {
    for (int j = 0; j < startShift.length; j++) {
      if (d.startTime[i] <= startShift[j] && startShift[j] <= d.endTime[i]) {
        availableShifts[j] = -1;
      } else if (d.startTime[i] < endShift[j] && endShift[j] <= d.endTime[i]) {
        // if the class ends when the shift starts, the shift is not included
        availableShifts[j] = 0;
      } else if (d.startTime[i] >= startShift[j] &&
          d.endTime[i] <= endShift[j]) {
        availableShifts[j] = -2;
      }
    }
  }

  return availableShifts;
}

class FreeShifts {
  late List<int> monday;
  late List<int> tuesday;
  late List<int> wednesday;
  late List<int> thursday;
  late List<int> friday;

  late Week week;

  late String mon;
  late String tue;
  late String wed;
  late String thu;
  late String fri;

  void changeToString(
      List<int> m, List<int> t, List<int> w, List<int> th, List<int> f) {
    mon = changeToStringOne(m);
    tue = changeToStringOne(t);
    wed = changeToStringOne(w);
    thu = changeToStringOne(th);
    fri = changeToStringOne(f);
  }

  String changeToStringOne(List<int> a) {
    String result = "";
    for (int i in a) {
      if (i <= 0) {
        continue;
      }
      result += "S$i,";
    }
    if (result.isNotEmpty) {
      result = result.substring(0, result.length - 1);
    }
    return result;
  }

  FreeShifts(Week w) {
    getWeeklyAvailableShifts(w);
    changeToString(monday, tuesday, wednesday, thursday, friday);
    week = w;
  }

  FreeShifts.desperate(Week w) {
    getDesperateWeeklyAvailableShifts(w);
    changeToString(monday, tuesday, wednesday, thursday, friday);
    week = w;
  }

  void getWeeklyAvailableShifts(Week week) {
    monday = getAvailableShifts(week.monday);
    tuesday = getAvailableShifts(week.tuesday);
    wednesday = getAvailableShifts(week.wednesday);
    thursday = getAvailableShifts(week.thursday);
    friday = getAvailableShifts(week.friday);
  }

  void getDesperateWeeklyAvailableShifts(Week week) {
    monday = getDesperateAvailableShifts(week.monday);
    tuesday = getDesperateAvailableShifts(week.tuesday);
    wednesday = getDesperateAvailableShifts(week.wednesday);
    thursday = getDesperateAvailableShifts(week.thursday);
    friday = getDesperateAvailableShifts(week.friday);
  }

  void printFreeWeeklyAvailableShifts() {
    String allFree = "S1,S2,S3,S4,S5,S6,S7,S8,S9,S10";
    if (mon == allFree &&
        tue == allFree &&
        wed == allFree &&
        thu == allFree &&
        fri == allFree) {
      print(
          "You don't have any classes in ApSpace for this week (Either you are on break or there is no schedule for this week yet)");
    } else {
      print("Monday: $mon");
      print("Tuesday: $tue");
      print("Wednesday: $wed");
      print("Thursday: $thu");
      print("Friday: $fri");
    }
  }

  Map<String, String> getFreeWeeklyAvailableShifts() {
    String allFree = "S1,S2,S3,S4,S5,S6,S7,S8,S9,S10";
    Map<String, String> result = {};
    if (mon == allFree &&
        tue == allFree &&
        wed == allFree &&
        thu == allFree &&
        fri == allFree) {
      result = {
        'Monday': '',
        "Tuesday": '',
        "Wednesday": '',
        "Thursday": '',
        "Friday": ''
      };
    } else {
      result = {
        'Monday': mon,
        "Tuesday": tue,
        "Wednesday": wed,
        "Thursday": thu,
        "Friday": fri
      };
    }

    return result;
  }
}

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

dynamic getJson(String path) async {
  try {
    var input = await File(path).readAsString();
    var map = jsonDecode(input);

    return map;
  } on PathNotFoundException {
    print("technicalAssistantsIntake.json doesn't exist in this path");
    String? s = stdin.readLineSync();
    exit(404);
  }
}

List<dynamic> getAllWeekFreeShifts(
    List<dynamic> taData, List<dynamic> jsonData, int numOfWeek) {
  List<dynamic> allWeekFreeShifts = [];

  for (var ta in taData) {
    Date secondThisMon = getThisWeekDate();
    if (numOfWeek == 2) {
      secondThisMon.addDate(7);
    } else if (numOfWeek == 3) {
      secondThisMon.addDate(14);
    }
    String intake = ta['intake'];
    String taName = ta['name'];
    String taGroup = ta['group'];

    if (intake == "") {
      continue;
    }

    if (taGroup != "none") {
      Week w = Week.withGroup(secondThisMon, jsonData, intake, "", taGroup);
      FreeShifts freeShifts = FreeShifts(w);
      Map<String, dynamic> scheduleMap = {
        'intake': intake,
        'name': taName,
        'Schedule': freeShifts.getFreeWeeklyAvailableShifts()
      };
      allWeekFreeShifts.add(scheduleMap);
    } else {
      Week w = Week(secondThisMon, jsonData, intake, "");
      FreeShifts freeShifts = FreeShifts(w);
      Map<String, dynamic> scheduleMap = {
        'intake': intake,
        'name': taName,
        'Schedule': freeShifts.getFreeWeeklyAvailableShifts()
      };
      allWeekFreeShifts.add(scheduleMap);
    }
  }

  return allWeekFreeShifts;
}

List<dynamic> getDesperateAllWeekFreeShifts(
    List<dynamic> taData, List<dynamic> jsonData, int numOfWeek) {
  List<dynamic> allWeekFreeShifts = [];

  for (var ta in taData) {
    Date secondThisMon = getThisWeekDate();
    if (numOfWeek == 2) {
      secondThisMon.addDate(7);
    } else if (numOfWeek == 3) {
      secondThisMon.addDate(14);
    }
    String intake = ta['intake'];
    String taName = ta['name'];
    String taGroup = ta['group'];

    if (intake == "") {
      continue;
    }

    if (taGroup != "none") {
      Week w = Week.withGroup(secondThisMon, jsonData, intake, "", taGroup);
      FreeShifts freeShifts = FreeShifts.desperate(w);
      Map<String, dynamic> scheduleMap = {
        'intake': intake,
        'name': taName,
        'Schedule': freeShifts.getFreeWeeklyAvailableShifts()
      };
      allWeekFreeShifts.add(scheduleMap);
    } else {
      Week w = Week(secondThisMon, jsonData, intake, "");
      FreeShifts freeShifts = FreeShifts.desperate(w);
      Map<String, dynamic> scheduleMap = {
        'intake': intake,
        'name': taName,
        'Schedule': freeShifts.getFreeWeeklyAvailableShifts()
      };
      allWeekFreeShifts.add(scheduleMap);
    }
  }

  return allWeekFreeShifts;
}

void getUnknownIntake(List<dynamic> taData) {
  List<String> unknownIntake = [];
  for (var ta in taData) {
    String intake = ta['intake'];
    String taName = ta['name'];
    if (intake == "") {
      unknownIntake.add(taName);
      continue;
    }
  }
  if (unknownIntake.isNotEmpty) {
    print(
        "$unknownIntake, these TAs does not have an intake yet. Please edit the technicalAssistansIntake.json");
  }
}

class AllWeeks {
  Week? week1;
  Week? week2;
  Week? week3;

  AllWeeks({w1, w2, w3}) {
    week1 = w1;
    week2 = w2;
    week3 = w3;
  }
}
