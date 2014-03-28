require! fs

e, data <- fs.readFile "./Sound.json"
tone = {}
sound = JSON.parse data
for let k, v of sound
  switch
  case v[0] is /ˊ/
    tone[k] = 2
  case v[0] is /ˇ/
    tone[k] = 3
  case v[0] is /ˋ/
    tone[k] = 3
  case v[0] is /˙/
    tone[k] = 3
  default
    tone[k] = 1

console.log JSON.stringify tone
