
# Dental Implant Adverse Event Analysis

This repository contains code and resources for analyzing adverse events related to dental implants, focusing on the impact of the COVID-19 pandemic. The project uses data from the FDA's Medical Device Reporting (MDR) system, including device details, adverse event narratives, and metadata. The main goal is to provide insights into the trends, safety, and effectiveness of dental implants before and after the pandemic using data science and NLP techniques.

## Repository Overview

This repository is organized into two main sections:
1. **Data Preprocessing**: Scripts and functions for initial data cleaning, merging, and transformation.
2. **Project Analysis**: Core analysis (to be completed) using preprocessed data to evaluate adverse events and identify significant trends related to dental implants.

---

## Part 1: Data Preprocessing

### Files

- **`Pre_process_1.R`**: Reads multiple device and FOI text files from different years, performs data cleaning, merging, and saves a consolidated dataset.
- **`Pre_process_2.R`**: Merges the preprocessed data with additional master records, removes unnecessary columns, and saves the final dataset for analysis.

### Prerequisites

To run the preprocessing scripts, ensure you have:

- **R (4.0 or higher)** installed
- Required packages: `pacman`, `tidyverse`, `readr`, `writexl`, `dplyr`

Install packages with the following command:

```r
if (!requireNamespace("pacman", quietly = TRUE)) install.packages("pacman")
pacman::p_load(tidyverse, readr, writexl, dplyr)
```

### Data Preprocessing Steps

#### `Pre_process_1.R`

1. **Load and Clean Device and FOI Text Data**: Reads and cleans yearly files by:
   - Removing entries with null address values.
   - Merging address fields into a single column.
   - Filtering records to retain only those with "DENTAL IMPLANT" in `GENERIC_NAME`.
2. **Ensure Column Type Consistency**: Ensures consistent data types across years.
3. **Combine Data**: Merges device and FOI text data across multiple years.
4. **Final Cleaning and Export**: Processes the FOI text data to remove unwanted patterns and saves the cleaned dataset as `cleaned_foi_and_dev_F.csv`.

#### `Pre_process_2.R`

1. **Load Preprocessed Files**:
   - Loads `cleaned_foi_and_dev_F.csv` from `Pre_process_1.R`.
   - Loads additional data from `mdrfoitru2023.csv`.
2. **Merge and Clean**:
   - Merges with master file data and removes redundant columns.
   - Saves the final dataset as `final_merged_dataset.csv`.
3. **Report Key Summary**: Calculates and outputs the number of distinct `MDR_REPORT_KEY` values.

### Output Files

- `combined_devices.rds`: Consolidated RDS file of all device data from multiple years.
- `cleaned_foi_and_dev_F.csv`: CSV with cleaned and merged FOI text data.
- `final_merged_dataset.csv`: Final processed and merged dataset.

---

## Part 2: Project Analysis (To be Completed)


---

## Acknowledgments

Special thanks to the University of Adelaide and my supervisor, Dr. Indu Bala, for their guidance and support.

---

Feel free to report any issues or contribute to this project by submitting a pull request.

```

This `README.md` is structured to reflect your current data preprocessing scripts and the planned project scope, as outlined in your progress report.
