# -------- Transitions
# Left-Transitions
text = text.gsub(/
  # Require preceding empty line or beginning of document
  (^[\ \t]* \n | \A)
  # 1 or more words, a space
  ^[\ \t]* (  \w+(?:\ \w+)* [\ ]
  # One of these words
  (UP|IN|OUT|BLACK|WITH)  (\ ON)?
  # Ending with transition punctuation
  ([\.\:][\ ]*)
  # and optional revision marker
  ({{%}})?  )\n
  # trailing empty line
  ^[\ \t]*$
/x, "\n"+'<transition>\2</transition>'+"\n")

# Right-Transitions
text = text.gsub(/
# Require preceding empty line or beginning of document
  (^[\ \t]* \n | \A)
# 1 or more words, a space
  ^[\ \t]* (  \w+(?:\ \w+)* [\ ]
# The word "TO"
  (TO)
# Ending in a colon, optional revision mark
  (\:)  ({{%}})?  $)\n
  # trailing empty line
  ^[\ \t]*$
/x, "\n"+'<transition>\2</transition>'+"\n")
