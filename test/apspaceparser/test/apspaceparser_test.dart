import 'package:apspaceparser/apspaceparser.dart';
import 'package:test/test.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'classes.dart';
import 'dart:io';

void main() async {
  var url = Uri.parse(
      "https://s3-ap-southeast-1.amazonaws.com/open-ws/weektimetable");
  var response = await http.get(url);
  if (response.statusCode == 200) {
    List<dynamic> jsonData = json.decode(response.body);

    while(true){
    print("Custom (Enter if not): ");

    

    String intake = "APU2F2309IT(FT)";

    String? special = stdin.readLineSync();

    print("");

    if (special == "hebert") {
      print("Special (Hebert)");
      intake = "APU2F2309SE";
      int numberOfWeeks = getNumberOfWeeks(getIntakeData(jsonData, intake));
      Date thisMon = getThisWeekDate();

      for (int i = 0; i < numberOfWeeks; i++) {
        print("${thisMon.date}-${thisMon.month}-${thisMon.year}");
        Week w = Week(thisMon, jsonData, intake, special);
        FreeShifts f = FreeShifts(w);
        f.printFreeWeeklyAvailableShifts();
        thisMon.addDate(3);
      }
    } else {
      print("Enter intake: ");

      String intake = stdin.readLineSync()!;

      try{
        int numberOfWeeks = getNumberOfWeeks(getIntakeData(jsonData, intake));
        Date thisMon = getThisWeekDate();

        for (int i = 0; i < numberOfWeeks; i++) {
          print("${thisMon.date}-${thisMon.month}-${thisMon.year}");
          Week w = Week(thisMon, jsonData, intake, "hebert");
          FreeShifts f = FreeShifts(w);
          f.printFreeWeeklyAvailableShifts();
          thisMon.addDate(3);
        } 
      }on RangeError{
          print("Intake does not exist in the data");
      }
      
    }
    print("");
    }
    // Date eleven = Date(m: 3, d: 5, y: 2024);

    // List<dynamic> todaySchedule = getOneDaySchedule(getIntakeData(jsonData, intake), eleven);

    // Day a = Day(eleven, todaySchedule);

    // int numberOfWeeks = getNumberOfWeeks(getIntakeData(jsonData, intake));
    // Date thisMon = getThisWeekDate();

    // print(a.startTime);
    // print(a.endTime);
    // print(getAvailableShifts(a));


    // for (int i = 0; i < numberOfWeeks; i++) {
    //   print("${thisMon.date}-${thisMon.month}-${thisMon.year}");
    //   Week w = Week(thisMon, jsonData, intake, "");
    //   FreeShifts f = FreeShifts(w);
    //   f.printFreeWeeklyAvailableShifts();
    //   thisMon.addDate(3);
    // }
  } else {
    print('Request failed with status: ${response.statusCode}.');
  }
}
