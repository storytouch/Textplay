# Misc Encoding
text = text.gsub(/^[ \t]*([=-]{3,})[ \t]*({{%}})?$/, '<page-break />')
text = text.gsub(/&/, '&#38;')
text = text.gsub(/([^-])--([^-])/, '\1&#8209;&#8209;\2')
text = text.gsub(/^[ \t]+$/, '')
text = text.gsub(/</, '&#60;')
text = text.gsub(/>/, '&#62;')
