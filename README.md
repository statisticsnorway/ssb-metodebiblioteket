
# Metodebiblioteket

[![R-CMD-check](https://github.com/statisticsnorway/ssb-metodebiblioteket/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/statisticsnorway/ssb-metodebiblioteket/actions/workflows/R-CMD-check.yaml)
[![pytest](https://github.com/statisticsnorway/ssb-metodebiblioteket/actions/workflows/pytest-check.yaml/badge.svg)](https://github.com/statisticsnorway/ssb-metodebiblioteket/actions/workflows/pytest.yaml)

Metodebiblioteket er SSBs bibliotek for funksjoner innen statistiske metoder. Dette repo-et inneholder informasjon om funksjonene som danner Metodebiblioteket. Mer informasjon finner du på [nettsiden til biblioteket](https://statisticsnorway.github.io/ssb-metodebiblioteket). 

## Installasjon

Repo-et er organisert som en R-pakke. For å installere repo-et og alle nødvendige metode-pakker kan du installere R-pakken metodebiblioteket fra [GitHub](https://github.com/statisticsnorway/ssb-metodebiblioteket/) ved å kjøre:

``` r
renv::install("statisticsnorway/ssb-metodebiblioteket")
```
Dette trenger du å gjøre kun én gang. For å ta i bruk R-funksjoner fra Metodebiblioteket må du kalle pakken hver gang du starter en ny R-sesjon ved å kjøre:
```r
library(metodebiblioteket)
```

## Nøkkelord

Nøkkelordene som brukes i Metodebiblioteket er basert på dokumentet
[Metodikk for modernisering av
statistikkproduksjonen](https://www.ssb.no/teknologi-og-innovasjon/artikler-og-publikasjoner/_attachment/419848?_ts=171cb1a9850):

| Hovednøkkelord       | Nøkkelord                                     |
|:---------------------|:----------------------------------------------|
| kontrollere          | regelbasert <br> statistisk                   |
| imputere             | modellbasert <br> donor                        |
| strukturere          |                                               |
| indeksberegning      |                                               |
| vektberegning        | modellbasert <br> designbasert                |
| usikkerhetsberegning |                                               |
| sesongjustering      |                                               |
| analyse              | romlig                                        |
| maskinlæring         |                                               |
| konfidensialitet     | undertrykking <br> avrunding <br> støylegging |

## Bidra med nye funksjoner

Har du utviklet en metodisk funksjon som kan være nyttig for andre i SSB? 
Her finner du [instruks om hvordan å legge til en ny funksjon](https://statisticsnorway.github.io/ssb-metodebiblioteket/bidra.html). For å bli inkludert i Metodebiblioteket er det et krav at funksjonen brukes i minst ett produksjonsløp eller i et av SSBs metodekurs. Funksjonene kan være i R eller Python.

## Status

Status på Metodebiblioteket ligger på [statussiden](https://statisticsnorway.github.io/ssb-metodebiblioteket/status.html).


