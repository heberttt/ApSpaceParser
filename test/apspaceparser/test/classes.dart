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

class Week{
  Day? monday;
  Day? tuesday;
  Day? wednesday;
  Day? thursday;
  Day? friday;
}

// Date getThisAndNextWeekDat(List<dynamic> data, String intake){
//   DateTime today = DateTime.now();
//   List<dynamic>? filteredData = [];

//   Date date =  Date(m: today.month, d: today.day - 7, y: today.year );
  
//   for (var i in data){
//     if (i['DAY'] == "MON" && date.compareDate(i['DATESTAMP_ISO']) && i['INTAKE'] == intake){
//       filteredData.add(i);
//     }
//   }

//   return filteredData;

// }


Date getThisWeekDate(List<dynamic> data){
  DateTime today = DateTime.now();
  int currentDay = today.weekday;

  Date date = Date(m: today.month, d: today.day, y: today.year);

  date.minDate(currentDay - 1);

  return date;
}

int getNumberOfWeeks(List<dynamic> data, String intake){
  Date thisMon = getThisWeekDate(data);

  //continue

  
  return 1;

}