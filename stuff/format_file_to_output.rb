# NOTE: - Set header and footer
# -----------------------------------------------------------------------------

# Final Draft's XML header
fdxStart = '<?xml version="1.0" encoding="UTF-8" standalone="no" ?>
<FinalDraft DocumentType="Script" Template="No" Version="1">
<Content>
'
# Final Draft's XML footer
fdxEnd = '</Content>
</FinalDraft>
'

fdxStart + text + fdxEnd
