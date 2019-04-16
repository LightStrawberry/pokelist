# -*- coding:utf-8 -*-
import json

with open("data/pokemon.json", 'rb') as f:
    pokemons = json.loads(f.read())


for i in range(len(pokemons)):
    raw = json.dumps(pokemons[i])
    input = open("data/pokemon/%s.json" % (i+1),"w")
    input.write(raw)