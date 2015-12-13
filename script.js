// Generated by CoffeeScript 1.10.0
(function() {
  var formal, reformat, toFull;

  String.prototype.replaceAt = function(index, character) {
    return this.substr(0, index) + character + this.substr(index + character.length);
  };

  toFull = function(str) {
    var c, i, k, ref;
    for (i = k = 0, ref = str.length; 0 <= ref ? k < ref : k > ref; i = 0 <= ref ? ++k : --k) {
      c = str.charCodeAt(i);
      if ((47 < c && c < 58) || (96 < c && c < 123) || (64 < c && c < 91)) {
        str = str.replaceAt(i, String.fromCharCode(c + 65248));
      }
    }
    return str;
  };

  formal = function(str) {
    var c, count, i, k, re, ref;
    re = /\.+/;
    str = str.replace(re, '……');
    count = 0;
    i = 0;
    for (i = k = 0, ref = str.length; 0 <= ref ? k < ref : k > ref; i = 0 <= ref ? ++k : --k) {
      c = str[i];
      if (c === '“' || c === '”' || c === '"' || c === "‘" || c === "’") {
        if (count === 0) {
          str = str.replaceAt(i, '「');
        } else {
          str = str.replaceAt(i, '」');
        }
        count = (count + 1) % 2;
      }
    }
    return str;
  };

  reformat = function() {
    var author, content, d, dstr, essay, full, j, k, l, len, meta, num_sent, paragraph, ref, ref1, sep, simplified, title;
    title = document.getElementById('title').value;
    author = document.getElementById('author').value;
    sep = parseInt(document.getElementById('sep').value);
    simplified = document.getElementById('simplified').checked && typeof(toSimp)!="undefined";
    full = document.getElementById('full').checked;
    essay = document.getElementById('original_text').value;
    if (sep <= 0) {
      alert("寬度需大於0");
      return;
    }
    if (title === '') {
      title = '標題';
    }
    d = new Date;
    dstr = (d.getFullYear()) + "/" + (d.getMonth() + 1) + "/" + (d.getDate());
    meta = "　　　　　　　　　　　　【" + title + "】\n\n\n作者：" + author + "\n" + dstr + "發表於：首發SexInSex\n字数：" + essay.length + "\n\n";
    content = "";
    ref = essay.split('\n');
    for (k = 0, len = ref.length; k < len; k++) {
      paragraph = ref[k];
      paragraph = paragraph.trim();
      if (paragraph === '') {
        continue;
      }
      paragraph = '　　' + paragraph;
      num_sent = Math.floor(paragraph.length / sep);
      if (paragraph.length % sep !== 0) {
        num_sent += 1;
      }
      for (j = l = 1, ref1 = num_sent; 1 <= ref1 ? l <= ref1 : l >= ref1; j = 1 <= ref1 ? ++l : --l) {
        content += paragraph.slice((j - 1) * sep, j * sep) + '\n';
      }
      content += '\n';
    }
    if (simplified) {
      meta = toSimp(meta);
    }
    if (full) {
      meta = toFull(meta);
    }
    if (simplified) {
      content = toSimp(content);
    }
    content = toFull(content);
    content = formal(content);
    return document.getElementById('result_text').value = meta + content;
  };

  window.reformat || (window.reformat = reformat);

}).call(this);
