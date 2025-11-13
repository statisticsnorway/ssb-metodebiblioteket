# -*- coding: utf-8 -*-
# ## Eksempel kjøring av reticulate

library(reticulate)

# #### Importere python pakke ssb-fagfunksjoner

fagfunksjoner <- import("fagfunksjoner")

# #### Kjøre funksjoner for å lage xml-fil som 

kjoenn_xml <- fagfunksjoner$make_klass_xml_codelist(
  path = "kjoenn.xml",
  codes = c("1", "2"),
  names_bokmaal = c("Mann", "Kvinne")
)
