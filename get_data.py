# -*- coding:utf-8 -*-
import json
from selenium import webdriver
from selenium.webdriver.common.by import By

with open("data/pokemon.json", 'rb') as f:
    pokemons = json.loads(f.read())

options = webdriver.ChromeOptions()
options.add_argument('headless')
options.add_argument("--proxy-server=socks5://127.0.0.1:1080")
driver = webdriver.Chrome('D:\\Program Files\\chromedriver', chrome_options=options)

for p in pokemons:
    id = p['id']
    driver.get('https://pokedex.org/#/pokemon/%s' % id)

    species = driver.find_element_by_xpath('//*[@id="detail-view"]/div[2]/div/div/div[2]/div[1]').get_attribute('textContent')
    description = driver.find_element_by_xpath('//*[@id="detail-view"]/div[2]/div/div/div[2]/div[2]').get_attribute('textContent')

    profile = {}
    minutia_key = driver.find_elements(By.XPATH, '//*[@id="detail-view"]/div[2]/div/div/div[2]/div/strong')
    minutia_value = driver.find_elements(By.XPATH, '//*[@id="detail-view"]/div[2]/div/div/div[2]/div/span')
    for n in range(len(minutia_key)):
        profile[minutia_key[n].get_attribute('textContent')[:-1]] = minutia_value[n].get_attribute('textContent')

    colors = driver.find_element_by_xpath('//*[@id="detail-view"]/div[2]/div/div/div[1]/div[2]/div[2]/div[1]/span[2]/div[1]').get_attribute('style')
    color = colors.split(';')[0][16:-1]

    p['species'] = species
    p['description'] = description
    p['profile'] = profile
    p['color'] = color

driver.quit()

raw = json.dumps(pokemons)
input = open("data/pokemon.json","w")
input.write(raw)
