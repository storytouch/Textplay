# ------- Dialogue

# The 2 search/replaces below, Standard and Escaped dialogue blocks,
# wrap the entire dialogue block in a wrapper. This allows much simpler
# regular expressions inside those blocks.

# ESCAPED DIALOGUE BLOCKS
text = text.gsub(/
# Require preceding empty line
^[\ \t]* \n
# Character Name
^\@(.+)\n
# Dialogue
(^[\ \t]* .+ \n)+
# Require trailing empty line or end of document
(^[\ \t]*$|\Z)
/x, "\n"+'<dialogue>'+'\0'+'</dialogue>'+"\n")


# NON-ESCAPED DIALOGUE-BLOCKS
text = text.gsub(/
# Require preceding empty line
^[\ \t]* \n
# Character Name + (Note)
^[\ \t]*[^a-z\n\t]+(\ *\(.+\))?
# Optional revision marker
({{%}})?\n
# Dialogue
(^[\ \t]* .+ \n)+
# Require trailing empty line or end of document
(^[\ \t]*$|\Z)
/x, "\n"+'<dialogue>'+'\0'+'</dialogue>'+"\n")

# Now that they're wrapped, tag the individual elements

# SEARCH THE DIALOGUE-BLOCK FOR ESCAPED CHARACTERS
text = text.gsub(/<dialogue>\n(.|\n)+?<\/dialogue>/x){|character|
    character.gsub(/(<dialogue>\n)[\ \t]*\@(.+)(?=\n)/, '\1<character>\2</character>')
}

# SEARCH THE DIALOGUE-BLOCK FOR NON-ESCAPED CHARACTERS
text = text.gsub(/<dialogue>\n(.|\n)+?<\/dialogue>/x){|character|
    character.gsub(/
      # beginning tag
      (<dialogue>\n)
      # Optional indentation
      [\ \t]*
      # The all-uppercase character name
      ([^a-z\n\t]+
      # Optional (note), case ignored
      (\ *\(.+\))?)
      # Optional revision marker
      ({{%}})?
      # with a newline ahead of it
      (?=\n)
      /x, '\1<character>\2\4</character>')
}

# SEARCH THE DIALOGUE-BLOCK FOR PARENTHETICALS
text = text.gsub(/<dialogue>\n(.|\n)+?<\/dialogue>/x){|paren|
    paren.gsub(/^[ \t]*(\([^\)]+\))[ \t]*({{%}})?(?=\n)/, '<paren>\1\2</paren>')
}

# SEARCH THE DIALOGUE-BLOCK FOR DIALOGUE
text = text.gsub(/<dialogue>\n(.|\n)+?<\/dialogue>/x){|talk|
    talk.gsub(/^[ \t]*(?! )([^<\n]+)$/, '<talk>\1</talk>')
}

# SEARCH THE DIALOGUE-BLOCK FOR LYRICS
text = text.gsub(/(<talk>)~(.+)(<\/talk>)/, '\1<lyric>\2</lyric>\3')


# Dual Dialogue Blocks
# --------------------

# Add a "join-marker" above the second character
# in a block of dual dialogue. The one with a fountain '^'
text = text.gsub(/^\n(<dialogue>\n<character>.+?)( +\^)({{%}})?(<\/character>)/, '<join-marker>' + "\n" + '\1\3\4')

# wrap dual dialogue in wrapper
text = text.gsub(/\n\n(<dialogue>\n(?:(?:.+\n)+))(<join-marker>)((?:\n.+)+)/, "\n\n" + '<wrap>' + "\n" + '\1\2\3' "\n" + '</wrap>')

# remove the <join-marker> and add "class" to <dialogue> tag
text = text.gsub(/(?<=<wrap>\n)<dialogue>\n((?:.+\n)+)<join-marker>\n<dialogue>/, '<dialogue class="dual first">' + "\n" + '\1' + '<dialogue class="dual second">')
