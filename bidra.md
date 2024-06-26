# Veiledning i hvordan å legge en funksjon inn i Metodebiblioteket
Her finner du veiledning om hvordan du kan bidra til Metodebiblioteket med en funksjon. 

1. **Clone repository og lage en ny branch**:
Clone repository fra [github](https://github.com/statisticsnorway/metodebiblioteket). Dette kan du gjøre fra terminalet eller fra inn i RStudio for eksempel. Lage en ny branch for endringer. 

2. **Legg funksjonen inn i create_table.R**: 
Åpne filen som ligger under "internal" som heter "create_table.R". Legg inn en ny rad med funksjonen "add_func()". Skriv navn av funksjonen, pakkenavn og stikkord. Standard stikkord som skal brukkes ligger på [Readme filen til repository](https://github.com/statisticsnorway/metodebiblioteket/blob/master/README.md#n%C3%B8kkelord). Skriv gjerne inn (GSBPM) prosessnummer i stikkord også. 

3. **Kjør add_func()**
Kjør den nye raden du har skrevet som inkludere *add_func()*. Dette oppdatere datafil som ligger bak Metodebiblioteket.

5. **Legg pakken som brukes inn i DESCRIPTION fil**: 
Hvis du har lagt inn en ny R funksjon skal pakken også ligge i DESCRIPTION filen under imports. Dette er for at Metodebiblioteket skal også fungere som en metapakke. Hvis pakken ligger der fra før er det ikke nødvendig å legge det inn på nytt.

6. **Skriv en enhetstest til funksjonen**: 
For å forsikre kvalitet til funksjonene vi inkluderer i Metodebiblioteket har vi et mål at alle funksjoner skal har minst en enhetstest. Disse testene kjøres automatisk ved endring til hoved branch for å sjekke at funksjoner fungere som de skal. For mer informasjon om enhetstest skriving se [Hadley Wickhams veiledning til testthat](https://r-pkgs.org/testing-basics.html) for R eller [veiledning til pytest](https://docs.pytest.org/en/7.4.x/getting-started.html) for python. Enhetstester i R skal ligge under mappen tests > testthat. Python enhetstester skal ligge under python > tests. 

7. **Commit og push endringer til github**:
Commit og push endringer til github. Alle endringer til create_table.R filen, data filen ("katalogdata.csv"), hjelpefiler (DESCRIPTION og reexports.R), og enhetstester skal inkluderes. Til slutt, lage en pull request for å merge branch inn til hovedbranch som da starter oppdatering av nettsiden automatisk.

