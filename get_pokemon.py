# -*- coding:utf-8 -*-
import json
import sys
from selenium import webdriver
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.common.by import By

options = Options()
options.add_argument('--headless')
options.add_argument('--disable-gpu')
# options.add_argument("--proxy-server=socks5://127.0.0.1:1080")
driver = webdriver.Chrome(executable_path='./chromedriver', chrome_options=options)

pokemons = []
for p in range(601, 700):
    driver.get('https://www.pokedex.app/zh/pokemon-%s' % p)

    name = driver.find_element_by_xpath('/html/body/main/article[2]/section[1]/table/tbody/tr[22]/td[2]').get_attribute('textContent')
    jp_name = driver.find_element_by_xpath('/html/body/main/article[2]/section[1]/table/tbody/tr[23]/td[2]').get_attribute('textContent')
    en_name = driver.find_element_by_xpath('/html/body/main/article[2]/section[1]/table/tbody/tr[24]/td[2]').get_attribute('textContent')
    ptype = driver.find_element_by_xpath('/html/body/main/article[2]/section[1]/table/tbody/tr[2]/td[2]').get_attribute('textContent')
    try:
        hp = driver.find_element(By.XPATH, '/html/body/main/article[2]/section[2]/table/tbody/tr[2]/td[1]').get_attribute('textContent')
    except Exception:
        print(p)
        sys.exit()
    try:
        atk = driver.find_element(By.XPATH, '/html/body/main/article[2]/section[2]/table/tbody/tr[3]/td[1]').get_attribute('textContent')
    except Exception:
        atk = "0"
    try:
        defense = driver.find_element(By.XPATH, '/html/body/main/article[2]/section[2]/table/tbody/tr[4]/td[1]').get_attribute('textContent')
    except Exception:
        defense = "0"
    try:
        spatk = driver.find_element(By.XPATH, '/html/body/main/article[2]/section[2]/table/tbody/tr[5]/td[1]').get_attribute('textContent')
    except Exception:
        spatk = "0"
    try:
        spdef = driver.find_element(By.XPATH, '/html/body/main/article[2]/section[2]/table/tbody/tr[6]/td[1]').get_attribute('textContent')
    except Exception:
        spdef = "0"
    try:
        speed = driver.find_element(By.XPATH, '/html/body/main/article[2]/section[2]/table/tbody/tr[7]/td[1]').get_attribute('textContent')
    except Exception:
        speed = "0"
    try:
        total = driver.find_element(By.XPATH, '/html/body/main/article[2]/section[2]/table/tbody/tr[8]/td[1]').get_attribute('textContent')
    except Exception:
        total = "0"
    height = driver.find_element(By.XPATH, '/html/body/main/article[2]/section[1]/table/tbody/tr[12]/td[2]').get_attribute('textContent')
    weight = driver.find_element(By.XPATH, '/html/body/main/article[2]/section[1]/table/tbody/tr[13]/td[2]').get_attribute('textContent')
    egg = driver.find_element(By.XPATH, '/html/body/main/article[2]/section[1]/table/tbody/tr[18]/td[2]').get_attribute('textContent')
    egg = egg.strip().split('/')
    egg = [x.strip() for x in egg]
    attribute_ids = []
    clz_a = driver.find_element(By.XPATH, '/html/body/main/article[2]/section[1]/table/tbody/tr[1]/td[2]/span[1]').get_attribute('class')
    attribute_ids.append(clz_a[6:])
    try:
        clz_b = driver.find_element(By.XPATH, '/html/body/main/article[2]/section[1]/table/tbody/tr[1]/td[2]/span[2]').get_attribute('class')
        attribute_ids.append(clz_b[6:])
    except Exception:
        pass

    try:
        ability = driver.find_element(By.XPATH, '/html/body/main/article[2]/section[1]/table/tbody/tr[9]/td[2]/a[1]').get_attribute('textContent')
    except Exception:
        ability = ""

    try:
        hidden_ability = driver.find_element(By.XPATH, '/html/body/main/article[2]/section[1]/table/tbody/tr[10]/td[2]/a[1]').get_attribute('textContent')
    except Exception:
        hidden_ability = ""

    pokemon = {'id': p, 'name': name, 'jp_name': jp_name, 'en_name': en_name, 'type': ptype, 'hp': hp, 'atk': atk, 'def': defense, 'spa': spatk, 'spd': spdef, \
               'spe': speed, 'total': total, 'height': height, 'weight': weight, 'egg': egg, 'attribute': attribute_ids, 'ability': ability, \
               'hidden_ability': hidden_ability}
    pokemons.append(pokemon)
    # minutia_value = driver.find_elements(By.XPATH, '//*[@id="detail-view"]/div[2]/div/div/div[2]/div/span')
    # for n in range(len(minutia_key)):
    # profile[minutia_key[n].get_attribute('textContent')[:-1]] = minutia_value[n].get_attribute('textContent')

    # colors = driver.find_element_by_xpath('//*[@id="detail-view"]/div[2]/div/div/div[1]/div[2]/div[2]/div[1]/span[2]/div[1]').get_attribute('style')
    # color = colors.split(';')[0][16:-1]

    # p['species'] = species
    # p['description'] = description
    # p['profile'] = profile
    # p['color'] = color

driver.quit()
print(pokemons)
raw = json.dumps(pokemons)
input = open("pokemond.json", "w")
input.write(raw)
