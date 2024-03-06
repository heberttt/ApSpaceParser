// import http package
import 'package:http/http.dart' as http;


void main() async {
  var url = Uri.parse('https://s3-ap-southeast-1.amazonaws.com/open-ws/weektimetable');
  // make http get request
  var response = await http.get(url);
  // check the status code for the result  
  if (response.statusCode == 200) {
    print(response.body);
  } else {
    print('Request failed with status: ${response.statusCode}.');
  }  

}
