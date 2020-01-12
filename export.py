#!/usr/bin/env python
# encoding: utf-8

import json
import sqlite3
import sys
reload(sys)
sys.setdefaultencoding('utf-8')

conn = sqlite3.connect("databases/pokedex.db")
print 'Opened database successfully'

# {u'profile': {u'Abilities': u'Download', u'Weight': u'82.5 kg', u'Catch Rate': u'0%', u'Gender Ratio': u'N/A', u'Height': u'1.5 m', u'Egg Groups': u'No Eggs', u'Hatch Steps': u'30600', u'EVs': u'1 Attack, 1 Speed, 1 Sp Att'}, u'description': u'This Pok\xe9mon existed 300 million years ago. Team Plasma altered it and attached a cannon to its back.', u'color': u'160, 160, 192', u'id': 809, u'base': {u'HP': 135, u'Attack': 143, u'Sp. Defense': 65, u'Defense': 143, u'Speed': 34, u'Sp. Attack': 80}, u'type': [u'Steel'], u'species': u'Paleozoic Pok\xe9mon', u'name': {u'japanese': u'\u30e1\u30eb\u30e1\u30bf\u30eb', u'chinese': u'\u7f8e\u5f55\u6885\u5854', u'english': u'Melmetal'}}
# conn.execute('DROP TABLE main.pokemon')
# conn.execute('''CREATE TABLE pokemon (
    # ID INT PRIMARY KEY NOT NULL,
    # name TEXT NOT NULL,
    # name_jp TEXT NOT NULL,
    # name_en TEXT NOT NULL,
    # hp INT NOT NULL,
    # atk INT NOT NULL,
    # def INT NOT NULL,
    # spa INT NOT NULL,
    # spd INT NOT NULL,
    # spe INT NOT NULL,
    # total INT NOT NULL,
    # type TEXT NOT NULL,
    # category TEXT NOT NULL,
    # ability TEXT NOT NULL,
    # hidden_ability TEXT NOT NULL,
    # egg TEXT NOT NULL,
    # height TEXT NOT NULL,
    # weight TEXT NOT NULL
# );
# ''')

with open("pokemond.json", 'r') as f:
    data = json.load(f)

    num = 0
    for d in data:
        num += 1
        print(d)
        # egg = [x.strip() for x in egg]
        sql = "insert into pokemon (id, name, name_jp, name_en, hp, atk, def, spa, spd, spe, total, type, category, ability, hidden_ability, egg, \
            height, weight) values (%d, '%s', '%s', '%s', %d, %d, %d, %d, %d, %d, %d, '%s', '%s', '%s', '%s', '%s', '%s', '%s')" % \
            (int(d['id']), d['name'], d['jp_name'], d['en_name'], int(d['hp']), int(d['atk']), int(d['def']), int(d['spa']), int(d['spd']), int(d['spe']), int(d['total']), \
             ",".join([str(i) for i in d['attribute']]), d['type'], d['ability'], d['hidden_ability'], \
             "/".join([str(i) for i in d['egg']]), \
             str(d['height']), str(d['weight']))
        conn.execute(sql)
        conn.commit()

conn.close()
