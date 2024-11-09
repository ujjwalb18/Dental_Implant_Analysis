
# Medical Device Data Preprocessing

This repository contains code for preprocessing medical device data files, specifically handling data related to dental implants. The data is cleaned, merged, and organized for analysis in two main scripts: `Pre_process_1.R` and `Pre_process_2.R`.

## Files

- **Pre_process_1.R**: Reads multiple yearly devices and FOI text files, cleans, merges, and saves them into a consolidated dataset.
- **Pre_process_2.R**: Loads the consolidated dataset and further merges it with additional data from a master CSV file, removes unnecessary columns, and saves the final dataset.

## Prerequisites

Ensure you have the following installed:

1. **R**: Version 4.0 or higher
2. **R Packages**:
   - `pacman`
   - `tidyverse`
   - `readr`
   - `writexl`
   - `dplyr`

### Installing Required Packages

In R, run the following command to install the necessary packages:

```r
if (!requireNamespace("pacman", quietly = TRUE)) install.packages("pacman")
pacman::p_load(tidyverse, readr, writexl, dplyr)
```

## Instructions

### Step 1: Run Pre_process_1.R

This script performs the following:

1. **Loads Device and FOI Data**: Reads multiple text files (e.g., DEVICE2016 to DEVICE2024) and FOI text files for each year.
2. **Data Cleaning**:
   - Removes entries with null values in manufacturer address fields.
   - Merges address fields into a single column.
   - Filters records to only include those with `GENERIC_NAME` containing "DENTAL IMPLANT".
3. **Column Type Consistency**: Ensures consistent column types between years.
4. **Combines Data**: Combines all yearly device and FOI data into one dataset and saves it as `combined_devices.rds`.
5. **Final Cleaned FOI Text Data**: Further processes FOI text data to remove unwanted patterns and exports the cleaned data as `cleaned_foi_and_dev_F.csv`.

**Run**:

```r
source("Pre_process_1.R")
```

### Step 2: Run Pre_process_2.R

This script performs the following:

1. **Load Processed Files**:
   - Loads `cleaned_foi_and_dev_F.csv` (output from `Pre_process_1.R`).
   - Loads `mdrfoitru2023.csv`, a master file with additional information.
2. **Merge and Clean**:
   - Merges the cleaned data with the master CSV by `MDR_REPORT_KEY`.
   - Removes redundant columns (e.g., separate address fields).
   - Saves the final dataset as `final_merged_dataset.csv`.
3. **Distinct MDR Report Count**: Calculates and displays the number of distinct `MDR_REPORT_KEY` values.

**Run**:

```r
source("Pre_process_2.R")
```

## Output Files

- `combined_devices.rds`: Consolidated RDS file of all device data from multiple years.
- `cleaned_foi_and_dev_F.csv`: CSV with cleaned and merged FOI text data.
- `final_merged_dataset.csv`: Final processed and merged dataset.

## Notes

- Ensure that all files (e.g., DEVICE and FOI text files) are in the appropriate folder specified in the code (`folder_path`).
- Both scripts should be run sequentially, as `Pre_process_2.R` relies on outputs from `Pre_process_1.R`.
  
Please report any issues or contribute to this project by submitting a pull request.


This `README.md` file provides clear documentation for users or collaborators to understand and work with your code. Adjust paths or specific details as needed based on your setup.
