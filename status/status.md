Status på Metodebiblioteket
================

- <a href="#status-på-metodebiblioteket"
  id="toc-status-på-metodebiblioteket">Status på metodebiblioteket</a>
  - <a href="#oversikt" id="toc-oversikt">Oversikt</a>
  - <a href="#nøkkelord" id="toc-nøkkelord">Nøkkelord</a>
  - <a href="#enhetstester" id="toc-enhetstester">Enhetstester</a>
  - <a href="#linker" id="toc-linker">Linker</a>
  - <a href="#antall-som-bruker-funksjoner-på-github"
    id="toc-antall-som-bruker-funksjoner-på-github">Antall som bruker
    funksjoner på github</a>

# Status på metodebiblioteket

[![R-CMD-check](https://github.com/statisticsnorway/metodebiblioteket/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/statisticsnorway/metodebiblioteket/actions/workflows/R-CMD-check.yaml)
[![pytest](https://github.com/statisticsnorway/metodebiblioteket/actions/workflows/pytest-check.yaml/badge.svg)](https://github.com/statisticsnorway/metodebiblioteket/actions/workflows/pytest.yaml)

Denne siden inneholder informasjon om status på funksjoner i SSBs
Metodebiblioteket. Den er status som er genererte 2023-10-20.

For å genere en ny rapport, åpne status.Rmd fil og velg “Knit with
parameters..”.

## Oversikt

Det er **46** funksjoner i Metodebiblioteket

## Nøkkelord

Nøkkelord brukes til å organisere Metodebiblioteket. Følgende ord brukes
i Metodebiblioteket. GSDPM steg nummer ikke inkluderes her.

| Nokkelord            | Antall |
|:---------------------|-------:|
| analyse              |      5 |
| avrunding            |      2 |
| designbasert         |      2 |
| donor                |      4 |
| imputere             |      9 |
| indeksberegning      |      2 |
| konfidensialitet     |     11 |
| kontrollere          |     11 |
| maskinlaering        |      2 |
| modellbasert         |      4 |
| python               |      3 |
| r                    |     43 |
| regelbasert          |      3 |
| romlig               |      2 |
| sesongjustering      |      5 |
| statistisk           |      9 |
| strukturere          |      3 |
| undertrykking        |     10 |
| usikkerhetsberegning |      3 |
| vektberegning        |      5 |

Følgende ord er nøkkelord knyttet til en funksjon men er ikke inn i
standardlisten

| Nokkelord: |
|:-----------|

## Enhetstester

Hver funksjon i Metodebiblioteket skal ha minst en enhetstest knyttet
til den. Dette er for å forsikre kvalitet og kunne tester funksjoner på
nye og gamle R installasjoner.

Følgende tabellen viser hvilke funksjoner mangler enhetstester eller har
enhetstester som feiler

| funksjon_navn          | status                                                                                                                                                    | detaljer |
|:-----------------------|:----------------------------------------------------------------------------------------------------------------------------------------------------------|:---------|
| confront               | <span style="     color: white !important;border-radius: 4px; padding-right: 4px; padding-left: 4px; background-color: orange !important;">mangler</span> |          |
| CountVectorizer        | <span style="     color: white !important;border-radius: 4px; padding-right: 4px; padding-left: 4px; background-color: orange !important;">mangler</span> |          |
| get_extremes           | <span style="     color: white !important;border-radius: 4px; padding-right: 4px; padding-left: 4px; background-color: orange !important;">mangler</span> |          |
| Hb                     | <span style="     color: white !important;border-radius: 4px; padding-right: 4px; padding-left: 4px; background-color: orange !important;">mangler</span> |          |
| impute_knn             | <span style="     color: white !important;border-radius: 4px; padding-right: 4px; padding-left: 4px; background-color: orange !important;">mangler</span> |          |
| impute_pmm             | <span style="     color: white !important;border-radius: 4px; padding-right: 4px; padding-left: 4px; background-color: orange !important;">mangler</span> |          |
| impute_proxy           | <span style="     color: white !important;border-radius: 4px; padding-right: 4px; padding-left: 4px; background-color: orange !important;">mangler</span> |          |
| impute_rhd             | <span style="     color: white !important;border-radius: 4px; padding-right: 4px; padding-left: 4px; background-color: orange !important;">mangler</span> |          |
| lm                     | <span style="     color: white !important;border-radius: 4px; padding-right: 4px; padding-left: 4px; background-color: orange !important;">mangler</span> |          |
| LmImpute               | <span style="     color: white !important;border-radius: 4px; padding-right: 4px; padding-left: 4px; background-color: orange !important;">mangler</span> |          |
| modifier               | <span style="     color: white !important;border-radius: 4px; padding-right: 4px; padding-left: 4px; background-color: orange !important;">mangler</span> |          |
| OLS                    | <span style="     color: white !important;border-radius: 4px; padding-right: 4px; padding-left: 4px; background-color: orange !important;">mangler</span> |          |
| OutlierRegressionMicro | <span style="     color: white !important;border-radius: 4px; padding-right: 4px; padding-left: 4px; background-color: orange !important;">mangler</span> |          |
| SVC                    | <span style="     color: white !important;border-radius: 4px; padding-right: 4px; padding-left: 4px; background-color: orange !important;">mangler</span> |          |
| validator              | <span style="     color: white !important;border-radius: 4px; padding-right: 4px; padding-left: 4px; background-color: orange !important;">mangler</span> |          |
| x13                    | <span style="     color: white !important;border-radius: 4px; padding-right: 4px; padding-left: 4px; background-color: orange !important;">mangler</span> |          |
| x13_automdl            | <span style="     color: white !important;border-radius: 4px; padding-right: 4px; padding-left: 4px; background-color: orange !important;">mangler</span> |          |
| x13_both               | <span style="     color: white !important;border-radius: 4px; padding-right: 4px; padding-left: 4px; background-color: orange !important;">mangler</span> |          |
| x13_pickmdl            | <span style="     color: white !important;border-radius: 4px; padding-right: 4px; padding-left: 4px; background-color: orange !important;">mangler</span> |          |
| x13_spec               | <span style="     color: white !important;border-radius: 4px; padding-right: 4px; padding-left: 4px; background-color: orange !important;">mangler</span> |          |

## Linker

Metodebiblioteket innholder mange linker til dokumentasjon av
funksjoner. Følgende funksjoner har linker som feiler:

| funksjon_navn | pakke |
|:--------------|:------|

## Antall som bruker funksjoner på github

Følgende funksjoner ble sjekket om de finnes på SSBs github (under
“stat-” repoer). Det sjekkes på både interne og public repoer (men ikke
de med mer begrenset tilgang). - LmImpute - struktur_model - Hb

Tabellen under viser hvor mange ganger de finnes og på hvilke repoer.

<table>
<thead>
<tr>
<th style="text-align:left;">
</th>
<th style="text-align:left;">
repo
</th>
<th style="text-align:right;">
LmImpute
</th>
<th style="text-align:right;">
struktur_model
</th>
<th style="text-align:right;">
Hb
</th>
<th style="text-align:right;">
SupressSmallCounts
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
13
</td>
<td style="text-align:left;">
stat-DETINV
</td>
<td style="text-align:right;">
0
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:right;">
0
</td>
<td style="text-align:right;">
0
</td>
</tr>
<tr>
<td style="text-align:left;">
20
</td>
<td style="text-align:left;">
stat-forbruk
</td>
<td style="text-align:right;">
142
</td>
<td style="text-align:right;">
0
</td>
<td style="text-align:right;">
0
</td>
<td style="text-align:right;">
0
</td>
</tr>
<tr>
<td style="text-align:left;">
30
</td>
<td style="text-align:left;">
stat-ledstill
</td>
<td style="text-align:right;">
0
</td>
<td style="text-align:right;">
2
</td>
<td style="text-align:right;">
0
</td>
<td style="text-align:right;">
0
</td>
</tr>
<tr>
<td style="text-align:left;">
47
</td>
<td style="text-align:left;">
stat-sykefratot
</td>
<td style="text-align:right;">
0
</td>
<td style="text-align:right;">
2
</td>
<td style="text-align:right;">
2
</td>
<td style="text-align:right;">
0
</td>
</tr>
</tbody>
</table>

[Tilbake til
metodebiblioteket](https://www.github.com/statisticsnorway/metodebiblioteket)
