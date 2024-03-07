class Day{
  List<int> startTime = [];
  List<int> endTime = [];
  Date? date;
  
  Day(Date d){
    date = d;
  }


}


class Date{
  int month = 0;
  int date = 0;
  int year = 0;

  Date({m,d,y}){
    month = m;
    date = d;
    year = y;
  }

  void addDate(int days){
    date += days;
    if (date > maxDate()){
      date -= maxDate();
      addMonth(1);
    }
  }

  void addMonth(int i){
    month += i;
    if (month > 12){
      month -= 12;
      year++;
    }
  }

  int maxDate(){
    if (month == 2){
      if (year % 4 == 0){
        return 29;
      }
      else{
        return 28;
      }
    }else if (month < 8 && month % 2 == 0){
      return 30;
    }else if (month >= 8 && month % 2 == 1){
      return 30;
    } else {
      return 31;
    }
  }

}

class Week{
  Day? monday;
  Day? tuesday;
  Day? wednesday;
  Day? thursday;
  Day? friday;
}

List<dynamic> getNextWeek(List<dynamic> data){
  DateTime today = DateTime.now();
  List<dynamic> filteredData = [];

  Date date =  Date(m: today.month, d: today.day, y: today.year );
  
  for (var i in data){
    if (i['DAY'] == "MON" && i['DATESTAMP_ISO'] ) //if date is more than today
  }



}