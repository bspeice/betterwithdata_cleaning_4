# MEPS Data Scraping
### A product of [Get Better With Data](http://getbetterwithdata.com/) Team 4
Get Better With Data Hackathon - Team 4 Cleaning - Medical Expenditure Panel Survey Scraping

----

# Using the data

All data is located in the `/data` folder as CSV files. There are two types:
- Non-Enhanced: Raw data converted from MEPS into a plain CSV
- Enhanced: Values for flags added to the dataset

# Using the scripts

To fetch more data from MEPS, you need R. The important functions are located in `/scripts/puf_download.R`. You can download data for any dataset if you have the PUF (ex: `HC-175E`). An example usage is as follows:

```
short_puf <- shorten_puf("HC-175E")
download_puf(short_puf)
# The file h175e.csv will be created in the current directory
```

All PUF files, regardless of what dataset they come from, can be downloaded through this command.

At this stage the `enrich_dataset.py` script can be used to add categorical labels and convert to better variable names.

```
# Usage:
enrich_dataset.py --input-file h94e.csv --column-dictionary FYCCodebook_2013.csv

```
The script will extract information about categorical variables in the input file using import.io API to parse codebook tables from the MEPS site and add columns with labels, rather than numeric IDs.

The column dictionary is one time construction from the codebooks on the MEPS website, mapping 8-character variable names
to more descriptive ones.
