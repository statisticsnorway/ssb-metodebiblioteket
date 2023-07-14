
<!-- README.md is generated from README.Rmd. Please edit that file -->

# metodebiblioteket

[![R-CMD-check](https://github.com/statisticsnorway/metodebiblioteket/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/statisticsnorway/metodebibliotek/actions/workflows/R-CMD-check.yaml)
[![pytest](https://github.com/statisticsnorway/metodebiblioteket/actions/workflows/pytest-check.yaml/badge.svg)](https://github.com/statisticsnorway/metodebibliotek/actions/workflows/pytest.yaml)

Denne repo-en inneholder informasjon om funksjoner som danne SSBs
Metodebiblioteket. Du kan se på biblioteket her:

**<https://statisticsnorway.github.io/metodebiblioteket/>**

## Installasjon

Repoen er organiserte som en R-pakke. For å installere det og alle
avhengige metode pakke

Du kan installere R-pakken metodebiblioteket fra
[GitHub](https://github.com/statisticsnorway/metodebiblioteket/) ved:

``` r
renv::install("statisticsnorway/metodebiblioteket")
```

## Nøkkelord

Nøkkelørd som brukes i Metodebiblioteket er baserte på dokumentet
[Metodikk for modernisering av
statistikkproduksjonen](https://www.ssb.no/teknologi-og-innovasjon/artikler-og-publikasjoner/_attachment/419848?_ts=171cb1a9850):

| Hovednøkkelord       | Nøkkelord                                     |
|:---------------------|:----------------------------------------------|
| kontrollere          | logisk <br> fordelings <br> innflytelses      |
| imputere             | modelbasert <br> donor                        |
| struktuere           |                                               |
| indeksberegning      |                                               |
| vektberegning        | modelbasert <br> designbasert                 |
| usikkerhetsberegning |                                               |
| sesongjustering      |                                               |
| analyse              |                                               |
| konfidensialitet     | undertrykking <br> avrunding <br> støylegging |

## Enhetstester

Hver funksjon i Metodebiblioteket skal ha minst en enhetstest knyttet
til den. Dette er for å forsikre kvalitet og kunne tester funksjoner på
nye og gamle R installasjoner.

Følgende tabellen viser hvilke funksjoner mangler enhetstester eller har
enhetstester som feiler

|     | funksjon_navn          | status                                                                                                                                                    | detaljer                                                                 |
|:----|:-----------------------|:----------------------------------------------------------------------------------------------------------------------------------------------------------|:-------------------------------------------------------------------------|
| 2   | CalcInd                | <span style="     color: white !important;border-radius: 4px; padding-right: 4px; padding-left: 4px; background-color: orange !important;">mangler</span> |                                                                          |
| 3   | CalcIndS2              | <span style="     color: white !important;border-radius: 4px; padding-right: 4px; padding-left: 4px; background-color: orange !important;">mangler</span> |                                                                          |
| 5   | confront               | <span style="     color: white !important;border-radius: 4px; padding-right: 4px; padding-left: 4px; background-color: orange !important;">mangler</span> |                                                                          |
| 9   | get_extremes           | <span style="     color: white !important;border-radius: 4px; padding-right: 4px; padding-left: 4px; background-color: orange !important;">mangler</span> |                                                                          |
| 10  | Hb                     | <span style="     color: white !important;border-radius: 4px; padding-right: 4px; padding-left: 4px; background-color: orange !important;">mangler</span> |                                                                          |
| 12  | impute_knn             | <span style="     color: white !important;border-radius: 4px; padding-right: 4px; padding-left: 4px; background-color: orange !important;">mangler</span> |                                                                          |
| 13  | impute_pmm             | <span style="     color: white !important;border-radius: 4px; padding-right: 4px; padding-left: 4px; background-color: orange !important;">mangler</span> |                                                                          |
| 14  | impute_proxy           | <span style="     color: white !important;border-radius: 4px; padding-right: 4px; padding-left: 4px; background-color: orange !important;">mangler</span> |                                                                          |
| 15  | impute_rhd             | <span style="     color: white !important;border-radius: 4px; padding-right: 4px; padding-left: 4px; background-color: orange !important;">mangler</span> |                                                                          |
| 16  | lm                     | <span style="     color: white !important;border-radius: 4px; padding-right: 4px; padding-left: 4px; background-color: orange !important;">mangler</span> |                                                                          |
| 17  | LmImpute               | <span style="     color: white !important;border-radius: 4px; padding-right: 4px; padding-left: 4px; background-color: orange !important;">mangler</span> |                                                                          |
| 19  | OutlierRegressionMicro | <span style="     color: white !important;border-radius: 4px; padding-right: 4px; padding-left: 4px; background-color: orange !important;">mangler</span> |                                                                          |
| 21  | PLSrounding            | <span style="     color: white !important;border-radius: 4px; padding-right: 4px; padding-left: 4px; background-color: orange !important;">mangler</span> |                                                                          |
| 27  | Rank2NumVar            | <span style="     color: white !important;border-radius: 4px; padding-right: 4px; padding-left: 4px; background-color: red !important;">feil</span>       | Tests that ‘identiske’ gives only values on both x and y for Rank2NumVar |
| 31  | struktur_model         | <span style="     color: white !important;border-radius: 4px; padding-right: 4px; padding-left: 4px; background-color: orange !important;">mangler</span> |                                                                          |
| 37  | ThError                | <span style="     color: white !important;border-radius: 4px; padding-right: 4px; padding-left: 4px; background-color: red !important;">feil</span>       | Test that correct values are included from ThError                       |
| 38  | validator              | <span style="     color: white !important;border-radius: 4px; padding-right: 4px; padding-left: 4px; background-color: orange !important;">mangler</span> |                                                                          |
| 39  | x13                    | <span style="     color: white !important;border-radius: 4px; padding-right: 4px; padding-left: 4px; background-color: orange !important;">mangler</span> |                                                                          |
| 40  | x13_automdl            | <span style="     color: white !important;border-radius: 4px; padding-right: 4px; padding-left: 4px; background-color: orange !important;">mangler</span> |                                                                          |
| 41  | x13_both               | <span style="     color: white !important;border-radius: 4px; padding-right: 4px; padding-left: 4px; background-color: orange !important;">mangler</span> |                                                                          |
| 42  | x13_pickmdl            | <span style="     color: white !important;border-radius: 4px; padding-right: 4px; padding-left: 4px; background-color: orange !important;">mangler</span> |                                                                          |
| 43  | x13_spec               | <span style="     color: white !important;border-radius: 4px; padding-right: 4px; padding-left: 4px; background-color: orange !important;">mangler</span> |                                                                          |

## Linker

Metodebiblioteket innholder mange linker til dokumentasjon av
funksjoner. Følgende funksjoner har linker som feiler:

| funksjon_navn    | pakke            |
|:-----------------|:-----------------|
| SdcForetakPerson | SdcForetakPerson |
