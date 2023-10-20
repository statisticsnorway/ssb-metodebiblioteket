
# metodebiblioteket

[![R-CMD-check](https://github.com/statisticsnorway/metodebiblioteket/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/statisticsnorway/metodebiblioteket/actions/workflows/R-CMD-check.yaml)
[![pytest](https://github.com/statisticsnorway/metodebiblioteket/actions/workflows/pytest-check.yaml/badge.svg)](https://github.com/statisticsnorway/metodebiblioteket/actions/workflows/pytest.yaml)

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


## Status

Status på Metodebiblioteket ligger på [status siden](https://github.com/statisticsnorway/metodebiblioteket/blob/master/status.md)
