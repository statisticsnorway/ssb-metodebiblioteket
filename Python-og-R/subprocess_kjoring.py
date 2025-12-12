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
#     display_name: Python 3 (ipykernel)
#     language: python
#     name: python3
# ---

# %% [markdown]
# # Eksempel kjøring av R-skript using `subprocess`

# %%
# Importere biblioteket
import subprocess

# %%
# Kjøre skript
subprocess.run(["Rscript", "beskytte_tabellen.R"])


# ### Kjøring med henting av output
#

# %%
output = subprocess.run(["Rscript", "beskytte_tabellen.R"], 
                        capture_output = True, text= True)

# %%
output


# ### Kjøring med argumenter

# %%
output = subprocess.run(["Rscript", "beskytte_tabellen_args.R", "tabell1", "tabell1_beskyttet"], 
                        capture_output = True, text= True)

# %%
