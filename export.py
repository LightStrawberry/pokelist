#!/usr/bin/env python
# encoding: utf-8

import json
import sqlite3

conn = sqlite3.connect("pokedex.sqlite3")
print 'Opened database successfully'

# {u'profile': {u'Abilities': u'Download', u'Weight': u'82.5 kg', u'Catch Rate': u'0%', u'Gender Ratio': u'N/A', u'Height': u'1.5 m', u'Egg Groups': u'No Eggs', u'Hatch Steps': u'30600', u'EVs': u'1 Attack, 1 Speed, 1 Sp Att'}, u'description': u'This Pok\xe9mon existed 300 million years ago. Team Plasma altered it and attached a cannon to its back.', u'color': u'160, 160, 192', u'id': 809, u'base': {u'HP': 135, u'Attack': 143, u'Sp. Defense': 65, u'Defense': 143, u'Speed': 34, u'Sp. Attack': 80}, u'type': [u'Steel'], u'species': u'Paleozoic Pok\xe9mon', u'name': {u'japanese': u'\u30e1\u30eb\u30e1\u30bf\u30eb', u'chinese': u'\u7f8e\u5f55\u6885\u5854', u'english': u'Melmetal'}}

# conn.execute('''CREATE TABLE pokemon
      # (ID INT PRIMARY KEY NOT NULL,
      # name TEXT NOT NULL,
      # weight TEXT NOT NULL);
# ''')

with open("data/pokemon.json", 'r') as f:
    data = json.load(f)

    num = 0
    for d in data:
        num += 1
        print(d)
        sql = "insert into pokemon (id, name, weight) values (%d, '%s', '%s')" % (num, d['name']['chinese'], d['profile']['Weight'])
        conn.execute(sql)

conn.commit()
conn.close()
