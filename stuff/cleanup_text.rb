# ---------- Cleanup

# This cleans up line-breaks within dialogue blocks
text = text.gsub(/<\/talk>[ \t]*(\n)[ \t]*<talk>/,'\1')

# This cleans up action paragraphs with line-breaks.
text = text.gsub(/<\/action>[ \t]*(\n)[ \t]*<action>/,'\1')

# Convert tabs to spaces within action
text = text.gsub(/<action>(.|\n)+?<\/action>/x){|tabs|
  tabs.gsub(/\t/, '    ')
}

# cleanup extra newlines around notes
text = text.gsub(/^\n\n(<note>)/, '\1')
text = text.gsub(/(<\/note>\n\n)\n/, '\1')
