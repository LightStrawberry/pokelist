# -*- coding:utf-8 -*-
import json

with open("data/pokemon.json", 'rb') as f:
    pokemons = json.loads(f.read())


for i in range(len(pokemons)):
    del pokemons[i]['id']
    pokemons[i]['base']['SpAttack'] = pokemons[i]['base']['Sp. Attack']
    del pokemons[i]['base']['Sp. Attack']
    pokemons[i]['base']['SpDefense'] = pokemons[i]['base']['Sp. Defense']
    del pokemons[i]['base']['Sp. Defense']
    pokemons[i]['profile']['CatchRate'] = pokemons[i]['profile']['Catch Rate']
    del pokemons[i]['profile']['Catch Rate']
    pokemons[i]['profile']['GenderRatio'] = pokemons[i]['profile']['Gender Ratio']
    del pokemons[i]['profile']['Gender Ratio']
    pokemons[i]['profile']['EggGroups'] = pokemons[i]['profile']['Egg Groups']
    del pokemons[i]['profile']['Egg Groups']
    pokemons[i]['profile']['HatchSteps'] = pokemons[i]['profile']['Hatch Steps']
    del pokemons[i]['profile']['Hatch Steps']
    raw = json.dumps(pokemons[i])
    input = open("data/pokemon/%s.json" % (i+1),"w")
    input.write(raw)