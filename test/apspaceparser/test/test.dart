import 'dart:io';

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


void main(){
  print(getPath());
}