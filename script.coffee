String::replaceAt = (index, character) ->
  @substr(0, index) + character + @substr(index + character.length)

toFull = (str) ->
    for i in [0...str.length]
        c = str.charCodeAt(i)
        if 47<c<58 or 96<c<123 or 64<c<91
            str = str.replaceAt(i, String.fromCharCode(c + 65248))
    str

formal = (str) ->
    re = /\.+/
    str = str.replace(re, '……')
    count = 0
    i = 0
    for i in [0...str.length]
        c = str[i]
        if c == '“' or c == '”' or c == '"' or c=="‘" or c=="’"
            if count == 0
              str = str.replaceAt(i, '「')
            else
                str = str.replaceAt(i, '」')
            count = (count + 1) % 2
    str

reformat = ->
    title = document.getElementById('title').value
    author = document.getElementById('author').value
    sep = parseInt(document.getElementById('sep').value)
    simplified = document.getElementById('simplified').checked
    full = document.getElementById('full').checked
    content = document.getElementById('original_text').value
    if sep<=0
        alert("寬度需大於0")
        return

    title = '標題' if title==''
    d = new Date
    dstr = "#{d.getFullYear()}/#{d.getMonth()+1}/#{d.getDate()}"
    result = "　　　　　　　　　　　　【#{title}】\n\n作者：#{author}\n#{dstr}發表於：首發SexinSex\n字数：#{content.length}\n\n"
    for paragraph in content.split('\n')
        paragraph = paragraph.trim()
        if paragraph==''
            continue
        paragraph = '　　' + paragraph
        num_sent = paragraph.length // sep
        num_sent += 1 if paragraph.length % sep != 0
        for j in [1..num_sent]
            result += paragraph.slice((j-1) * sep, j * sep) + '\n'
        result+='\n'
    result = toSimp(result) if simplified
    result = toFull(result) if full
    result = formal(result)
    document.getElementById('result_text').value = result
    return

window.reformat or= reformat
