# ---
# jupyter:
#   jupytext:
#     formats: py:percent
#     text_representation:
#       extension: .py
#       format_name: percent
#       format_version: '1.3'
#       jupytext_version: 1.18.1
#   kernelspec:
#     display_name: Python-og-R
#     language: python
#     name: python-og-r
# ---

# %% [markdown]
# # Eksempel kjøring av R-funksjoner using RWrapR

# %%
# Importere biblioteket
import rwrapr as wr
import numpy as np
import pandas as pd

# %%
# Lage noen data
dt = {'vei_nr': np.repeat(['s1', 's2', 's3', 's4', 's5', 's6'], 4),
        'ulykke_grad': ['alvorlig', 'lett', 'ingen', 'ukjent'] * 6,
        'frekvens': [4, 2, 5, 0, 5, 8, 1, 0, 3, 2, 6, 0, 4, 1, 4, 0, 1, 3, 8, 1, 2, 5, 6, 0]
}
tabell1 = pd.DataFrame(dt)

# %%
tabell1

# %%
# Hente inn GaussSuppresion pakke
gs = wr.library("GaussSuppression") 

# %%
# Bruke SuppressSmallCounts funksjonen fra pakken
tabell1_beskyttet = gs.SuppressSmallCounts(data = tabell1, 
                                         maxN = 3,  
                                         freqVar = "frekvens", 
                                         dimVar = np.array([1, 2])
                                        )

# %%
tabell1_beskyttet
