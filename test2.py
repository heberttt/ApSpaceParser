from selenium import webdriver
import time
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC


driver = webdriver.Edge()

wait = WebDriverWait(driver, 30)

driver.get("https://apspace.apu.edu.my/student-timetable")

#wait.until(EC.title_is("aaaa"))
time.sleep(20)


html = driver.execute_script("return document.documentElement.outerHTML")

print(html)
