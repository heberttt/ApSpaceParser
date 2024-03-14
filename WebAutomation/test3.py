from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC

# add headless browser

options = webdriver.ChromeOptions()
options.add_argument('headless')
driver = webdriver.Chrome(options=options)

wait = WebDriverWait(driver, 30)

driver.get("https://apspace.apu.edu.my/student-timetable")

# wait for the button to be clickable
button = wait.until(EC.element_to_be_clickable((By.CLASS_NAME, "button-native")))
button.click()

# wait for some time to allow the page to load
wait.until(EC.presence_of_element_located((By.TAG_NAME, "html")))

html = driver.execute_script("return document.documentElement.outerHTML")

print(html)

driver.quit()
