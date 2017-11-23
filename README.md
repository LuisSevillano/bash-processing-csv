## Search for a term within a csv
A `bash` script that makes you easy to search by a concrete term within a `csv` file and write a new one with the results of the search.
The script needs three parameters
```
./search.sh [future-folder-name] [search-term] [search-column] [file]
```
To search and filter for all the airports/heliports in California fom [this](http://ourairports.com/data/) `airports.csv`.
```
./search.sh EEUU US-CA 10 airports.csv
```

Don't forget to set execution permissions on that file with `chmod +x ./search.sh`
