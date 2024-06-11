- Make sure that the technicalAssistantsIntake.json is in the same directory as the .exe file.
- If a ta intake changes, update the json file.
- This will calculate schedule based on their apspace (includes optional modules that they dont have).
- If a ta have class right before the shift, the shift will not be included in fear of class delay (ex: i have class at 1:30-2:30, the shift at 2:30-3:30 will not be included)
- If a ta doesnt have any schedule (could be on holiday/ wrong intake or group / not generated yet by apspace) for the specific week. 
They will not be displayed as available but displayed that their schedule is not available. 

hr:
-Type "hr" when prompt "Custom (Enter if not): " appears
 1.This will show you all the available TAs on that specific shift
 2.If the timetable for the next 2 weeks is available, it will display in the "available weeks". However, there are chances that some intake schedules haven't been generated.

-Typing "hr_desperate" when prompt "Custom (Enter if not) : " appears will remove the "If a ta have class right before the shift,
the shift will not be included in fear of class delay(ex: i have class at 1:30-2:30, the shift at 2:30-3:30 will not be included)" 
condition. (Unrecommended)
