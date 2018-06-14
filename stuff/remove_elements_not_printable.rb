# Remove any DOS-style line endings:
text = text.gsub(/\r\n/, "\n")

# Start by completely removing bonyard comments and notes. It is impossible to
# prevent additional transformations inside them when newlines are present.
# They must also be removed so they don't interfere with the transformation
# of adjacent elements.

# Boneyard
text = text.gsub(/\/\*(.|\n)+?\*\//, '')

# Fountain [[notes]]
text = text.gsub(/\[{2}[^\]]+\]{2}/,'')
