require! fs

e, data <- fs.readFile "./Sound.json"
sound = JSON.parse data
e, data <- fs.readFile "./dict-revised.json"
dict = JSON.parse data

pos = {}
for d in dict
  continue unless sound[d.title]
  pos[d.title] = {}
  for heteronym in d.heteronyms
    for def in heteronym.definitions
      pos[d.title][def.type] = true if def.type

console.log JSON.stringify pos
