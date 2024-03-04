from selenium import webdriver

# Provide the path to the ChromeDriver executable
chrome_driver_path = '/home/himagi/Documents/project/ApSpaceParser/chromedriver'

# Create a WebDriver instance using the ChromeDriver executable path
driver = webdriver.Chrome(executable_path = chrome_driver_path)

# Navigate to the Bing homepage
driver.get("https://www.bing.com")

# Print the current URL after navigating
print(driver.current_url)

# Close the browser
driver.quit()

