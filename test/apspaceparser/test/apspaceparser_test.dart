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

		print(a.startTime);
		print(a.endTime);

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





