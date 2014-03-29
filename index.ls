create-block = ->
  if Math.random! > 0.5
    x = window.seq.0
    if x
      $ \body .prepend "<div class='ui huge button sliding'>#x</div>"
  else
    i = Math.floor Math.random!*(Object.keys(window.TONES).length)
    x = Object.keys(window.TONES)[i]
    if x
      $ "<div class='ui huge button sliding'>#x</div>" .prependTo \body
  
check-row = (i) ->
  to-symbol = (bool) ->
    switch bool
    | true  => "✓"
    | false => "✗"
  str = ""
  $ "\#r#i" .children \td .children \div .each (i, x) ->
    str += $(x).html! if $(x).html! != "&nbsp;&nbsp;"
  console.log str
  if str.length == 5 and check-tone window.q, str
    $ "\#r#i" .children \td .children \div .addClass \green
    alert """
    #{window.q.join ""}，#{str}。
    
    斷詞：#{ to-symbol check-token window.q, str }
    平仄：#{ to-symbol check-tone window.q, str }
    詞性：#{ to-symbol check-pos window.q, str }
    """

check-token = (words, sentence) ->
  i = 0
  for l in words.map(-> it.length)
    return false unless window.WORDS[l][sentence.substr(i, l)]
    i++
  true

check-tone = (words, sentence) ->
  i = 0
  for w in words
    return false unless window.TONES[w[*-1]] is not window.TONES[sentence.substr(i, w.length)[*-1]]
    i += w.length
  true

check-pos = (words, sentence) ->
  for w, i in words.join("").split("")
    same-type = false
    for type, _ of window.POS[w]
      same-type = true if window.POS[sentence[i]][type]
    return false unless same-type
  true

check-meaning = (words, sentence) ->
  # TODO: 根據 wordnet 判斷同義、反義詞？
  false

check-radical = (words, sentence) ->
  # TODO: 比較兩個字的部首
  false

bind-q = (q) ->
  for w, i in q.join "" .split ""
    $ "\#q#i" .html w

window.WORDS = {}
words <- $.getJSON 'common.1.json'
window.WORDS.1 = words
console.log Object.keys(window.WORDS.1).length
words <- $.getJSON 'common.2.json'
window.WORDS.2 = words
console.log Object.keys(window.WORDS.2).length
words <- $.getJSON 'common.3.json'
window.WORDS.3 = words
console.log Object.keys(window.WORDS.3).length
tones <- $.getJSON 'tone.json'
window.TONES = tones
pos <- $.getJSON 'pos.json'
window.POS = pos

<- $
window.seq = <[零 媒 現 真 實]>
window.q = <[馬 鹿 如 唬 口]>
  #console.log check-token <[國 泰 民 安]>, \風調雨順
  #console.log check-tone <[漏盡 飛身 去]>, \心空及第歸
  #console.log check-pos <[漏盡 飛身 去]>, \心空及第歸
bind-q window.q

$ \body .on \click ".sliding" ->
  $ ".sliding" .removeClass \red
  $ this .addClass \red
  window.selected = $ this .html!
  console.log window.selected

$ \body .on \click ".slot" ->
  if window.selected
    $ this
      .removeClass \slot
      .html window.selected
    window.seq.shift! if window.selected == window.seq.0
    window.selected = void
    $ ".red.sliding" .remove!
    check-row($(this).parents \tr .0.id.1)

$ \body .on "animationend webkitAnimationEnd oAnimationEnd MSAnimationEnd" ".sliding" ->
  console.log \end
  $ this .remove!

create-block!
<- setInterval _, 1000ms
create-block!
