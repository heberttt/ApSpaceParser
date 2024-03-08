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

		Date a = getThisAndNextWeekDate(jsonData, "APU2F2309SE");

		print(a.date);
		print(a.month);
		print(a.year);

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





