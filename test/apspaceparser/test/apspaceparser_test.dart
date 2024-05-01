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
    while (true) {
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
      } else if (special == "exit") {
        exit(0);
      } else if (special == "hr") {
        var technicalAssistantsIntakes = await getJson(getPath());

        List<dynamic> taData = technicalAssistantsIntakes;
        while (true) {
          Date thisMon1 = getThisWeekDate();
          int weekQuantity = getNumberOfWeeks(jsonData);
          String nextWeek = "";
          String thirdWeek = "";

          String thisWeek = "${thisMon1.date}-${thisMon1.month}-${thisMon1.year}";
          if (weekQuantity > 1){
            thisMon1.addDate(7);
            nextWeek = "${thisMon1.date}-${thisMon1.month}-${thisMon1.year}";
          }
          if (weekQuantity > 2){
            thisMon1.addDate(7);
            thirdWeek = "${thisMon1.date}-${thisMon1.month}-${thisMon1.year}";
          }
          
          
          if (weekQuantity == 1){
            print("Available weeks: $thisWeek");
          }else if (weekQuantity == 2){
            print("Available weeks: $thisWeek, $nextWeek");
          }else if (weekQuantity > 2){
            print("Available weeks : $thisWeek, $nextWeek, $thirdWeek");
          }

          

          print("Enter the week (ex:4-3-2024): ");
          String? selection = stdin.readLineSync();
          
          String? selectedWeek;
          if (selection == "1"){
            selectedWeek = thisWeek;
          }else if (selection == "2"){
            selectedWeek = nextWeek;
          }else if (selection == "3"){
            selectedWeek = thirdWeek;
          }
          
          print("Enter the day (ex:Monday): ");
          String? selectedDay = stdin.readLineSync();
          print("Enter the shift (Just enter from 1 to 10) : ");
          String? selectedShift = stdin.readLineSync();

          if (selectedWeek == "" || selectedDay == "" || selectedShift == "") {
            print("Please enter again");
            continue;
          }
          else{
            List<dynamic> allFreeShifts = [];
            for(int i = 0; i < weekQuantity; i++){
              List<dynamic> freeShiftsWeek = getAllWeekFreeShifts(taData, jsonData, i + 1);
              allFreeShifts.add(freeShiftsWeek);
            }

            List<dynamic> freeShiftForThisWeek = [];
            List<String> availableTas = [];
            List<String> ambiguousTas = [];

            if (selectedWeek == thisWeek){
              freeShiftForThisWeek = allFreeShifts[0];
              for(int i = 0; i < freeShiftForThisWeek.length; i++){
                String freeShiftStr = freeShiftForThisWeek[i]['Schedule'][selectedDay];
                List<String> freeShiftArr = freeShiftStr.split(",");
                String taGroup = '';
                  if (freeShiftForThisWeek[i]['group'] == null){
                    taGroup = "All";
                  }
                  else{
                    taGroup = freeShiftForThisWeek[i]['group'];
                  }
                if (freeShiftArr.contains("S$selectedShift")){
                  
                  availableTas.add(freeShiftForThisWeek[i]['name'] + " (${freeShiftForThisWeek[i]['intake']}) (Group : $taGroup)");
                }
                if (freeShiftStr == ''){
                  ambiguousTas.add(freeShiftForThisWeek[i]['name'] + " (${freeShiftForThisWeek[i]['intake']})  (Group : $taGroup)");
                }
              }
              
            }else if (selectedWeek == nextWeek){
              freeShiftForThisWeek = allFreeShifts[1];
              for(int i = 0; i < freeShiftForThisWeek.length; i++){
                String freeShiftStr = freeShiftForThisWeek[i]['Schedule'][selectedDay];
                List<String> freeShiftArr = freeShiftStr.split(",");
                String taGroup = '';
                  if (freeShiftForThisWeek[i]['group'] == null){
                    taGroup = "All";
                  }
                  else{
                    taGroup = freeShiftForThisWeek[i]['group'];
                  }
                if (freeShiftArr.contains("S$selectedShift")){
                  availableTas.add(freeShiftForThisWeek[i]['name'] + " (${freeShiftForThisWeek[i]['intake']}) (Group : $taGroup)");
                }if (freeShiftStr == ''){
                  ambiguousTas.add(freeShiftForThisWeek[i]['name'] + " (${freeShiftForThisWeek[i]['intake']}) (Group : $taGroup)");
                }
              }
            }else if (selectedWeek == thirdWeek){
              freeShiftForThisWeek = allFreeShifts[2];
              for(int i = 0; i < freeShiftForThisWeek.length; i++){
                String freeShiftStr = freeShiftForThisWeek[i]['Schedule'][selectedDay];
                List<String> freeShiftArr = freeShiftStr.split(",");
                String taGroup = '';
                  if (freeShiftForThisWeek[i]['group'] == null){
                    taGroup = "All";
                  }
                  else{
                    taGroup = freeShiftForThisWeek[i]['group'];
                  }
                if (freeShiftArr.contains("S$selectedShift")){
                  availableTas.add(freeShiftForThisWeek[i]['name'] + " (${freeShiftForThisWeek[i]['intake']}) (Group : $taGroup)");
                }if (freeShiftStr == ''){
                  ambiguousTas.add(freeShiftForThisWeek[i]['name'] + " (${freeShiftForThisWeek[i]['intake']}) (Group : $taGroup)");
                }
              }
            }
            print("");
            getUnknownIntake(taData);
            print("");
            if(ambiguousTas.isNotEmpty){
              print("$ambiguousTas, these TA's schedule is not available yet for this week (Either on holiday or week not generated yet by ApSpace.)");
              print("");
            }
            
            print("These TA are available at S$selectedShift on $selectedDay for the Week of $selectedWeek: ");
            for (var technicalAssistant in availableTas){
              print(technicalAssistant);
            }
            
          break;
        }}
      }else if (special == "hr_desperate") {
        var technicalAssistantsIntakes = await getJson(getPath());

        List<dynamic> taData = technicalAssistantsIntakes;
        while (true) {
          Date thisMon1 = getThisWeekDate();
          int weekQuantity = getNumberOfWeeks(jsonData);
          String nextWeek = "";
          String thirdWeek = "";

          String thisWeek = "${thisMon1.date}-${thisMon1.month}-${thisMon1.year}";
          if (weekQuantity > 1){
            thisMon1.addDate(7);
            nextWeek = "${thisMon1.date}-${thisMon1.month}-${thisMon1.year}";
          }
          if (weekQuantity > 2){
            thisMon1.addDate(7);
            thirdWeek = "${thisMon1.date}-${thisMon1.month}-${thisMon1.year}";
          }
          
          
          if (weekQuantity == 1){
            print("Available weeks: $thisWeek");
          }else if (weekQuantity == 2){
            print("Available weeks: $thisWeek, $nextWeek");
          }else if (weekQuantity > 2){
            print("Available weeks : $thisWeek, $nextWeek, $thirdWeek");
          }

          

          print("Enter the week (ex:4-3-2024): ");
          String? selectedWeek = stdin.readLineSync();
          print("Enter the day (ex:Monday): ");
          String? selectedDay = stdin.readLineSync();
          print("Enter the shift (Just enter from 1 to 10) : ");
          String? selectedShift = stdin.readLineSync();

          if (selectedWeek == "" || selectedDay == "" || selectedShift == "") {
            print("Please enter again");
            continue;
          }
          else{
            List<dynamic> allFreeShifts = [];
            for(int i = 0; i < weekQuantity; i++){
              List<dynamic> freeShiftsWeek = getDesperateAllWeekFreeShifts(taData, jsonData, i + 1);
              allFreeShifts.add(freeShiftsWeek);
            }

            List<dynamic> freeShiftForThisWeek = [];
            List<String> availableTas = [];
            List<String> ambiguousTas = [];

            if (selectedWeek == thisWeek){
              freeShiftForThisWeek = allFreeShifts[0];
              for(int i = 0; i < freeShiftForThisWeek.length; i++){
                String freeShiftStr = freeShiftForThisWeek[i]['Schedule'][selectedDay];
                List<String> freeShiftArr = freeShiftStr.split(",");
                String taGroup = '';
                  if (freeShiftForThisWeek[i]['group'] == null){
                    taGroup = "All";
                  }
                  else{
                    taGroup = freeShiftForThisWeek[i]['group'];
                  }
                if (freeShiftArr.contains("S$selectedShift")){
                  availableTas.add(freeShiftForThisWeek[i]['name'] + " (${freeShiftForThisWeek[i]['intake']}) (Group : $taGroup)");
                }
                if (freeShiftStr == ''){
                  ambiguousTas.add(freeShiftForThisWeek[i]['name'] + " (${freeShiftForThisWeek[i]['intake']}) (Group : $taGroup)");
                }
              }
              
            }else if (selectedWeek == nextWeek){
              freeShiftForThisWeek = allFreeShifts[1];
              for(int i = 0; i < freeShiftForThisWeek.length; i++){
                String freeShiftStr = freeShiftForThisWeek[i]['Schedule'][selectedDay];
                List<String> freeShiftArr = freeShiftStr.split(",");
                String taGroup = '';
                  if (freeShiftForThisWeek[i]['group'] == null){
                    taGroup = "All";
                  }
                  else{
                    taGroup = freeShiftForThisWeek[i]['group'];
                  }
                if (freeShiftArr.contains("S$selectedShift")){
                  availableTas.add(freeShiftForThisWeek[i]['name'] + " (${freeShiftForThisWeek[i]['intake']}) (Group : $taGroup)");
                }if (freeShiftStr == ''){
                  ambiguousTas.add(freeShiftForThisWeek[i]['name'] + " (${freeShiftForThisWeek[i]['intake']}) (Group : $taGroup)");
                }
              }
            }else if (selectedWeek == thirdWeek){
              freeShiftForThisWeek = allFreeShifts[2];
              for(int i = 0; i < freeShiftForThisWeek.length; i++){
                String freeShiftStr = freeShiftForThisWeek[i]['Schedule'][selectedDay];
                List<String> freeShiftArr = freeShiftStr.split(",");
                if (freeShiftArr.contains("S$selectedShift")){
                  availableTas.add(freeShiftForThisWeek[i]['name'] + " (${freeShiftForThisWeek[i]['intake']})");
                }if (freeShiftStr == ''){
                  ambiguousTas.add(freeShiftForThisWeek[i]['name'] + " (${freeShiftForThisWeek[i]['intake']})");
                }
              }
            }
            print("");
            getUnknownIntake(taData);
            print("");
            if(ambiguousTas.isNotEmpty){
              print("$ambiguousTas, these TA's schedule is not available yet for this week (Either on holiday or week not generated yet by ApSpace.)");
              print("");
            }
            
            print("These TA are available at S$selectedShift on $selectedDay for the Week of $selectedWeek: ");
            for (var technicalAssistant in availableTas){
              print(technicalAssistant);
            }
            
          break;
        }}
      } else {
        print("Enter intake: ");

        String intake = stdin.readLineSync()!;

        try {
          int numberOfWeeks = getNumberOfWeeks(getIntakeData(jsonData, intake));
          Date thisMon = getThisWeekDate();

          for (int i = 0; i < numberOfWeeks; i++) {
            print("${thisMon.date}-${thisMon.month}-${thisMon.year}");
            Week w = Week(thisMon, jsonData, intake, special);
            FreeShifts f = FreeShifts(w);
            f.printFreeWeeklyAvailableShifts();
            thisMon.addDate(3);
          }
        } on RangeError {
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
