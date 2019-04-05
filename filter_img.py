#!/usr/bin/python
# -*- coding: UTF-8 -*-

import os, sys

path = "./assets/thumbnails/"

f = os.listdir(path)

n = 0
for i in f:
    oldname = path + f[n]
    newname = path + f[n][:3] + ".png"

    os.rename(oldname, newname)
    print(oldname,'======>',newname)

    n += 1
