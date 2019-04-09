# -*- coding:utf-8 -*-
import json
from selenium import webdriver
from selenium.webdriver.common.by import By

    
options = webdriver.ChromeOptions()
options.add_argument('headless')
options.add_argument("--proxy-server=socks5://127.0.0.1:1080")
driver = webdriver.Chrome('D:\\Program Files\\chromedriver', chrome_options=options)

with open("data/pokemon.json", 'rb') as f:
    pokemons = json.loads(f.read())

pokemons_data = []
for p in pokemons:
    name = p['name']['english'].lower()
    id = p['id']
    driver.get('https://pokemondb.net/pokedex/%s' % name)

    moves_table = driver.find_element_by_xpath('//*[@id="tab-moves-16"]/div[1]/div[1]/div[1]/table/tbody')
    moves = moves_table.find_elements_by_xpath(".//tr")
    learn = []
    for m in moves:
        lv = m.find_element_by_class_name('cell-num').get_attribute('textContent')
        name = m.find_element_by_class_name('cell-name').get_attribute('textContent')
        type = m.find_element_by_class_name('cell-icon').get_attribute('textContent')
        cat = m.find_element_by_class_name('img-fixed').get_attribute('title')
        power = m.find_elements_by_class_name('cell-num')[1].get_attribute('textContent')
        acc = m.find_elements_by_class_name('cell-num')[2].get_attribute('textContent')
        l = {"lv": lv, "name": name, "type": type, "cat": cat, "power": power, "acc": acc}
        learn.append(l)

    tm_moves_table = driver.find_element_by_xpath('//*[@id="tab-moves-16"]/div[1]/div[2]/div/table/tbody')
    tm_moves = tm_moves_table.find_elements_by_xpath(".//tr")
    tm_data = []
    for m in tm_moves:
        tm = m.find_element_by_class_name('cell-num').get_attribute('textContent')
        name = m.find_element_by_class_name('cell-name').get_attribute('textContent')
        type = m.find_element_by_class_name('cell-icon').get_attribute('textContent')
        cat = m.find_element_by_class_name('img-fixed').get_attribute('title')
        power = m.find_elements_by_class_name('cell-num')[1].get_attribute('textContent')
        acc = m.find_elements_by_class_name('cell-num')[2].get_attribute('textContent')
        t = {"tm": tm, "name": name, "type": type, "cat": cat, "power": power, "acc": acc}
        tm_data.append(t)

    egg_moves_table = driver.find_element_by_xpath('//*[@id="tab-moves-16"]/div[1]/div[1]/div[2]/table/tbody')
    egg_moves = egg_moves_table.find_elements_by_xpath(".//tr")
    egg = []
    for m in egg_moves:
        name = m.find_element_by_class_name('cell-name').get_attribute('textContent')
        type = m.find_element_by_class_name('cell-icon').get_attribute('textContent')
        cat = m.find_element_by_class_name('img-fixed').get_attribute('title')
        power = m.find_elements_by_class_name('cell-num')[0].get_attribute('textContent')
        acc = m.find_elements_by_class_name('cell-num')[1].get_attribute('textContent')
        e = {"name": name, "type": type, "cat": cat, "power": power, "acc": acc}
        egg.append(e)

    tutor_moves_table = driver.find_element_by_xpath('//*[@id="tab-moves-16"]/div[1]/div[1]/div[2]/table/tbody')
    tutor_moves = tutor_moves_table.find_elements_by_xpath(".//tr")
    tutor = []
    for m in tutor_moves:
        name = m.find_element_by_class_name('cell-name').get_attribute('textContent')
        type = m.find_element_by_class_name('cell-icon').get_attribute('textContent')
        cat = m.find_element_by_class_name('img-fixed').get_attribute('title')
        power = m.find_elements_by_class_name('cell-num')[0].get_attribute('textContent')
        acc = m.find_elements_by_class_name('cell-num')[1].get_attribute('textContent')
        tu = {"name": name, "type": type, "cat": cat, "power": power, "acc": acc}
        tutor.append(tu)

    transfer_moves_table = driver.find_element_by_xpath('//*[@id="tab-moves-16"]/div[2]/table/tbody')
    transfer_moves = transfer_moves_table.find_elements_by_xpath(".//tr")
    transfer = []
    for m in transfer_moves:
        name = m.find_element_by_class_name('cell-name').get_attribute('textContent')
        type = m.find_element_by_class_name('cell-icon').get_attribute('textContent')
        cat = m.find_element_by_class_name('img-fixed').get_attribute('title')
        power = m.find_elements_by_class_name('cell-num')[0].get_attribute('textContent')
        acc = m.find_elements_by_class_name('cell-num')[1].get_attribute('textContent')
        tr = {"name": name, "type": type, "cat": cat, "power": power, "acc": acc}
        transfer.append(tr)

    moves = {'learn': learn, 'egg': egg, 'tm': tm_data, 'tutor': tutor, 'transfer': transfer}
    data = {'id': id, 'moves': moves}
    pokemons_data.append(data)

driver.quit()

raw = json.dumps(pokemons_data)
input = open("data/moves.json","w")
input.write(raw)