from bs4 import BeautifulSoup
import requests

#soup = BeautifulSoup()

URL = "https://apspace.apu.edu.my/student-timetable"

headerss = {
        'User-Agent' : 'TP067551'
        }


url = 'http://worldagnetwork.com/'
result = requests.get(URL)
print(result.content.decode())




