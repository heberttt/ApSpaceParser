import 'package:apspaceparser/apspaceparser.dart';
import 'package:test/test.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'classes.dart';

void main() async{
	var url = Uri.parse("https://s3-ap-southeast-1.amazonaws.com/open-ws/weektimetable");
	var response = await http.get(url);
	if(response.statusCode == 200){
		List<dynamic> jsonData = json.decode(response.body);



		print(getNumberOfWeeks(getIntakeData(jsonData, "APU2F2309SE")));
		Date eleven = Date(m: 3, d:11, y:2024);
		
		List<dynamic> todaySchedule = getOneDaySchedule(getIntakeData(jsonData,"APU2F2309SE"), eleven);

		Day a = Day(eleven, todaySchedule);

		Week b = Week(eleven, jsonData);

    int numberOfWeeks = getNumberOfWeeks(getIntakeData(jsonData, "APU2F2309SE"));
    Date thisMon = getThisWeekDate();
    

    for (int i = 0; i < numberOfWeeks; i++){
      Week w = Week(thisMon, jsonData);
      w.printSchedule();
      thisMon.addDate(3);
    }

    


		// if(jsonData != null){
		// 	print(getThisWeekMondayDate(jsonData, "APU2F2309SE"));
		// }else{
		// 	print("Next week schedule is not available yet.");
		// }

		// for (var element in jsonData){
		// 	if  (element['INTAKE'] == "APU2F2309SE"){
		// 		//print(element);
        
		// 	}
		// }

		
		

	}else{
		print('Request failed with status: ${response.statusCode}.');
	}
}





