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
