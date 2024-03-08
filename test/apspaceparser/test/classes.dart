class Day{
  List<int> startTime = [];
  List<int> endTime = [];
  Date? date;
  List<dynamic> todaySchedule = [];
  
  Day(Date d, List<dynamic> todaySchedule){
    date = d;
    this.todaySchedule = todaySchedule;
    getStartAndEndTime();
  }

  void getStartAndEndTime(){
    for(var i in todaySchedule){
      Time s = Time(i['TIME_FROM']);
      Time e = Time(i['TIME_TO']);
      startTime.add(s.getTime());
      endTime.add(e.getTime());
    }
  }




}

class Week{
  Day? monday;
  Day? tuesday;
  Day? wednesday;
  Day? thursday;
  Day? friday;

  Week(Date start, List<dynamic> data){
    monday = Day(start, getOneDaySchedule(getIntakeData(data,"APU2F2309SE"), start));
    start.addDate(1);
    tuesday = Day(start, getOneDaySchedule(getIntakeData(data,"APU2F2309SE"), start));
    start.addDate(1);
    wednesday = Day(start, getOneDaySchedule(getIntakeData(data,"APU2F2309SE"), start));
    start.addDate(1);
    thursday = Day(start, getOneDaySchedule(getIntakeData(data,"APU2F2309SE"), start));
    start.addDate(1);
    friday = Day(start, getOneDaySchedule(getIntakeData(data,"APU2F2309SE"), start));
  }


  
}

class Time{
  int hour = 0;
  int minute = 0;


  Time(String t){
    List<String> timeSplit = t.split(" ");
    List<String> timeSplitSplit = timeSplit[0].split(":");
    hour = int.parse(timeSplitSplit[0]);
    minute = int.parse(timeSplitSplit[1]);
    if (timeSplit[1] == "PM"){
      hour += 12;
      if (hour > 23){
        hour -= 12;
      }
    }
  }
  int getTime(){
    String result = "$hour$minute";
    if (minute == 0){
      result = hour.toString() + "00";
    }
    return int.parse(result);
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

  void minDate(int days){
    date -= days;
    if(date < 1){
      date += maxDate();
      minMonth(1);
    }
  }
  
  void minMonth(int i){
    month -= i;
    if (month < 1){
      month += 12;
      year--;
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

  bool compareDate(String m){
    List<String> ymdMB = m.split("-");
    List<String> ymdTB = [year.toString(), month.toString(), date.toString()];
    List<int> ymdM = [int.parse(ymdMB[0]), int.parse(ymdMB[1]), int.parse(ymdMB[2])];
    List<int> ymdT = [int.parse(ymdTB[0]), int.parse(ymdTB[1]), int.parse(ymdTB[2])];

    if (ymdM[0] > ymdT[0]){
      return true;
    }else if (ymdM[0] == ymdT[0]){
      if (ymdM[1] > ymdT[1]){
        return true;
      }else if(ymdM[1] == ymdT[1]){
        if (ymdM[2] > ymdT[2]){
          return true;
        }else if (ymdM[2] == ymdT[0]){
          return false;   // if both days are mondays, it will not accept (change when needed)
        }else{
          return false;
        }
      }else{
        return false;
      }
    }else{
      return false;
    }
    
  }

}



List<dynamic> getIntakeData(List<dynamic> data, String intake){
  List<dynamic>? filteredData = [];
  
  for (var i in data){
    if (i['INTAKE'] == intake){
      filteredData.add(i);
    }
  }

  return filteredData;

}


Date getThisWeekDate(List<dynamic> data){
  DateTime today = DateTime.now();
  int currentDay = today.weekday;

  Date date = Date(m: today.month, d: today.day, y: today.year);

  date.minDate(currentDay - 1);

  return date;
}

int getNumberOfWeeks(List<dynamic> data){
  Date thisMon = getThisWeekDate(data);

  Date nextMon = getThisWeekDate(data);
  nextMon.addDate(7);

  Date twoNextMon = getThisWeekDate(data);
  nextMon.addDate(14);

  var lastIndex = data[data.length - 1];

  String lastDate = lastIndex['DATESTAMP_ISO'];

  if(twoNextMon.compareDate(lastDate)){
    return 3;
  }
  else if (nextMon.compareDate(lastDate)){
    return 2;
  }
  
  return 1;

}

List<dynamic> getOneDaySchedule(List<dynamic> schedule, Date today){
  String todayStr = (today.year).toString() + "-" + (today.month).toString() + "-" + (today.date).toString();
  List<dynamic> todaySchedule = [];

  

  for (var i in schedule){
    String a = i['DATESTAMP_ISO'];
    List<String> asplit = a.split("-");
    Date formattedDate = Date(y: int.parse(asplit[0]) , m: int.parse(asplit[1]), d: int.parse(asplit[2]));
    String f = (formattedDate.year).toString() + "-" + (formattedDate.month).toString() + "-" + (formattedDate.date).toString();
    if (f == todayStr){
      todaySchedule.add(i);
    }
  }

  return todaySchedule;
}