from bs4 import BeautifulSoup
import requests

#soup = BeautifulSoup()

URL = "https://apspace.apu.edu.my/student-timetable"


result = requests.get(URL)
print(result.content.decode())




