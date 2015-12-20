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
    essay  = document.getElementById('original_text').value
    if sep<=0
        alert("寬度需大於0")
        return

    title = '標題' if title==''
    d = new Date
    dstr = "#{d.getFullYear()}/#{d.getMonth()+1}/#{d.getDate()}"
    pad = Math.floor((35-title.length-2)/2)+1
    console.log(pad)
    meta = Array(pad).join('　')+"【#{title}】\n\n\n作者：#{author}\n#{dstr}發表於：首發SexInSex\n字数：#{essay.length}\n\n"

    content = ""
    for paragraph in essay .split('\n')
        paragraph = paragraph.trim()
        if paragraph==''
            continue
        paragraph = '　　' + paragraph
        num_sent = paragraph.length // sep
        num_sent += 1 if paragraph.length % sep != 0
        for j in [1..num_sent]
            content += paragraph.slice((j-1) * sep, j * sep) + '\n'
        content +='\n'
    console.log(TongWen.s2t)
    meta = TongWen.convert(meta, "simplified") if simplified
    meta = toFull(meta) if full
    content = TongWen.convert(content, "simplified") if simplified
    content = toFull(content) if full
    content = formal(content)
    document.getElementById('result_text').value = (meta+content)

window.reformat or= reformat
