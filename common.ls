require! fs

e, data <- fs.readFile "./Sound.json"
sound = JSON.parse data
e, data <- fs.readFile "./dict-revised.json"
dict = JSON.parse data

words = {}
for d in dict
  common = true
  for w in d.title.split("")
    common := false unless sound[w]

  continue unless common and d.title.length == parseInt process.argv.2
  words[d.title] = true

console.log JSON.stringify words
