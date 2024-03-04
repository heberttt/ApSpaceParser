from selenium import webdriver
import time
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC

#add headless browser

driver = webdriver.Chrome()

wait = WebDriverWait(driver, 30)

driver.get("https://apspace.apu.edu.my/student-timetable")

#wait.until(EC.title_is("aaaa"))
time.sleep(7)

name_class = "ion-color ion-color-primary md button button-outline ion-activatable ion-focusable hydrated" 

print(driver.page_source)

button = driver.find_element(By.XPATH , ("//ion-button[@class='ion-color ion-color-primary md button button-outline ion-activatable ion-focusable hydrated']"));

# clicking on the button
button.click()

time.sleep(10)

searchbar = driver.find_element(By.XPATH, "//input[@class='searchbar-input sc-ion-searchbar-md']")


intake = "APU2F2309SE"

searchbar.send_keys(intake)

searchbar.send_keys(Keys.RETURN)

time.sleep(2)

match_using_text = driver.find_element(By.XPATH, "//ion-item[contains(text(), 'APU2F2309SE')]")

match_using_text.click()



html = driver.execute_script("return document.documentElement.outerHTML")

print(html)

time.sleep(5)
driver.close()



