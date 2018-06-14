# ------- Scene Headings

# FULLY-FORMED SLUGLINES
text = text.gsub(/
# Require leading empty line - or the beginning of file
(?i:^\A | ^[\ \t]* \n)
# Respect leading whitespace
^[\ \t]*
# Standard prefixes, allowing for bold-italic
((?:[\*\_])*(i\.?\/e|int\.?\/ext|ext|int|est)
# A separator between prefix and location
(\ +|\.\ ?).*) \n
# Require trailing empty line
^[\ \t]* \n
/xi, "\n"+'<sceneheading>\1</sceneheading>'+"\n\n")
