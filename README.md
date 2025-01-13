
# metodebiblioteket

[![R-CMD-check](https://github.com/statisticsnorway/ssb-metodebiblioteket/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/statisticsnorway/ssb-metodebiblioteket/actions/workflows/R-CMD-check.yaml)
[![pytest](https://github.com/statisticsnorway/ssb-metodebiblioteket/actions/workflows/pytest-check.yaml/badge.svg)](https://github.com/statisticsnorway/ssb-metodebiblioteket/actions/workflows/pytest.yaml)

Denne repo-en inneholder informasjon om funksjoner som danne SSBs
Metodebiblioteket. Du kan se på biblioteket her:

**<https://statisticsnorway.github.io/ssb-metodebiblioteket/>**

## Installasjon

Repoen er organiserte som en R-pakke. For å installere det og alle
avhengige metode pakke

Du kan installere R-pakken metodebiblioteket fra
[GitHub](https://github.com/statisticsnorway/ssb-metodebiblioteket/) ved:

``` r
renv::install("statisticsnorway/ssb-metodebiblioteket")
```
Dette trenger du å gjøre kun en gang. For å ta i bruk R funksjoner i Metodebiblioteket må du kalle inn pakken hver gang du starte en ny R sesjon med:
```r
library(metodebiblioteket)
```

## Nøkkelord

Nøkkelørd som brukes i Metodebiblioteket er baserte på dokumentet
[Metodikk for modernisering av
statistikkproduksjonen](https://www.ssb.no/teknologi-og-innovasjon/artikler-og-publikasjoner/_attachment/419848?_ts=171cb1a9850):

| Hovednøkkelord       | Nøkkelord                                     |
|:---------------------|:----------------------------------------------|
| kontrollere          | regelbasert <br> statistisk                   |
| imputere             | modelbasert <br> donor                        |
| strukturere          |                                               |
| indeksberegning      |                                               |
| vektberegning        | modellbasert <br> designbasert                |
| usikkerhetsberegning |                                               |
| sesongjustering      |                                               |
| analyse              | romlig                                        |
| maskinlæring         |                                               |
| konfidensialitet     | undertrykking <br> avrunding <br> støylegging |

## Legg inn en ny funksjon

Har du en metodiske funksjon som du mener bør ligge inn i Metodebiblioteket? Her finne du [instruks om hvordan å legge inn en ny funkjson](https://statisticsnorway.github.io/ssb-metodebiblioteket/bidra.html). Husk at et av kravene er at funksjoner brukes i minst et produksjonsløp eller i et av SSBs metode-kursene. Funksjoner kan være i R eller Python. 


## Status

Status på Metodebiblioteket ligger på [status siden](https://statisticsnorway.github.io/ssb-metodebiblioteket/status.html)


