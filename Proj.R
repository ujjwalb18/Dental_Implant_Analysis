# Load pacman package
pacman::p_load(tidyverse,readr,writexl)

# Defining the path to the folder
folder_path <- "C:/Project data Final/Project data Final/"

# Defining each file path separately
file_path_DEVICE2018 <- file.path(folder_path, "DEVICE2018.txt")
file_path_DEVICE2019 <- file.path(folder_path, "DEVICE2019.txt")
file_path_DEVICE2020 <- file.path(folder_path, "DEVICE2020.txt")
file_path_DEVICE2021 <- file.path(folder_path, "DEVICE2021.txt")
file_path_DEVICE2022 <- file.path(folder_path, "DEVICE2022.txt")
file_path_foitext2018 <- file.path(folder_path, "foitext2018.txt")
file_path_foitext2019 <- file.path(folder_path, "foitext2019.txt")
file_path_foitext2020 <- file.path(folder_path, "foitext2020.txt")
file_path_foitext2021 <- file.path(folder_path, "foitext2021.txt")
file_path_foitext2022 <- file.path(folder_path, "foitext2022.txt")

# Reading each file into a separate variable using read_delim
DEVICE2018 <- read_delim(file_path_DEVICE2018, delim = "|")
DEVICE2019 <- read_delim(file_path_DEVICE2019, delim = "|")
DEVICE2020 <- read_delim(file_path_DEVICE2020, delim = "|")
DEVICE2021 <- read_delim(file_path_DEVICE2021, delim = "|")
DEVICE2022 <- read_delim(file_path_DEVICE2022, delim = "|")

# Removing the Null addresses 
DEVICE2018 <- DEVICE2018[!is.na(DEVICE2018$MANUFACTURER_D_ADDRESS_1) & !is.na(DEVICE2018$MANUFACTURER_D_ADDRESS_2), ]
DEVICE2019 <- DEVICE2019[!is.na(DEVICE2019$MANUFACTURER_D_ADDRESS_1) & !is.na(DEVICE2019$MANUFACTURER_D_ADDRESS_2), ]
DEVICE2020 <- DEVICE2020[!is.na(DEVICE2020$MANUFACTURER_D_ADDRESS_1) & !is.na(DEVICE2020$MANUFACTURER_D_ADDRESS_2), ]
DEVICE2021 <- DEVICE2021[!is.na(DEVICE2021$MANUFACTURER_D_ADDRESS_1) & !is.na(DEVICE2021$MANUFACTURER_D_ADDRESS_2), ]
DEVICE2022 <- DEVICE2022[!is.na(DEVICE2022$MANUFACTURER_D_ADDRESS_1) & !is.na(DEVICE2022$MANUFACTURER_D_ADDRESS_2), ]

# Function to merge address columns
merge_address_columns <- function(df) {
  df$MANUFACTURER_D_ADDRESS <- paste(
    df$MANUFACTURER_D_ADDRESS_1, df$MANUFACTURER_D_ADDRESS_2, 
    df$MANUFACTURER_D_STATE_CODE, df$MANUFACTURER_D_ZIP_CODE, 
    df$MANUFACTURER_D_ZIP_CODE_EXT, df$MANUFACTURER_D_COUNTRY_CODE, 
    df$MANUFACTURER_D_POSTAL_CODE,
    sep = " "
  )
  
  # Remove the original columns
  df$MANUFACTURER_D_ADDRESS_1 <- NULL
  df$MANUFACTURER_D_ADDRESS_2 <- NULL
  df$MANUFACTURER_D_STATE_CODE <- NULL
  df$MANUFACTURER_D_ZIP_CODE <- NULL
  df$MANUFACTURER_D_ZIP_CODE_EXT <- NULL
  df$MANUFACTURER_D_COUNTRY_CODE <- NULL
  df$MANUFACTURER_D_POSTAL_CODE <- NULL
  
  return(df)
}

# Applying the function to all data frames
DEVICE2018 <- merge_address_columns(DEVICE2018)
DEVICE2019 <- merge_address_columns(DEVICE2019)
DEVICE2020 <- merge_address_columns(DEVICE2020)
DEVICE2021 <- merge_address_columns(DEVICE2021)
DEVICE2022 <- merge_address_columns(DEVICE2022)

# Filtering rows with GENERIC_NAME containing "DENTAL IMPLANT"
DEVICE2018 <- DEVICE2018[grepl("DENTAL IMPLANT", DEVICE2018$GENERIC_NAME, ignore.case = TRUE), ]
DEVICE2019 <- DEVICE2019[grepl("DENTAL IMPLANT", DEVICE2019$GENERIC_NAME, ignore.case = TRUE), ]
DEVICE2020 <- DEVICE2020[grepl("DENTAL IMPLANT", DEVICE2020$GENERIC_NAME, ignore.case = TRUE), ]
DEVICE2021 <- DEVICE2021[grepl("DENTAL IMPLANT", DEVICE2021$GENERIC_NAME, ignore.case = TRUE), ]
DEVICE2022 <- DEVICE2022[grepl("DENTAL IMPLANT", DEVICE2022$GENERIC_NAME, ignore.case = TRUE), ]


# Combining all the device data frames into one
combined_devices <- bind_rows(DEVICE2018, DEVICE2019, DEVICE2020, DEVICE2021, DEVICE2022)

# Removing individual data frames (to maintain memory usage)
rm(DEVICE2018, DEVICE2019, DEVICE2020, DEVICE2021, DEVICE2022)

foitext2018 <- read_delim(file_path_foitext2018, delim = "|")
foitext2019 <- read_delim(file_path_foitext2019, delim = "|")
foitext2020 <- read_delim(file_path_foitext2020, delim = "|")
foitext2021 <- read_delim(file_path_foitext2021, delim = "|")
foitext2022 <- read_delim(file_path_foitext2022, delim = "|")

# Functioning to merge FOI_TEXT for same MDR_REPORT_KEY and keep other columns as the first entry
merge_foi_text <- function(df) {
  library(dplyr)
  
  # Grouping by MDR_REPORT_KEY and merge FOI_TEXT
  df <- df %>%
    group_by(MDR_REPORT_KEY) %>%
    summarise(
      MDR_TEXT_KEY = first(MDR_TEXT_KEY),
      TEXT_TYPE_CODE = first(TEXT_TYPE_CODE),
      PATIENT_SEQUENCE_NUMBER = first(PATIENT_SEQUENCE_NUMBER),
      DATE_REPORT = first(DATE_REPORT),
      FOI_TEXT = paste(FOI_TEXT, collapse = " ")
    )
  
  return(df)
}

# Performing the erging for the datasets
ft2018 <- merge_foi_text(foitext2018)
rm(foitext2018)

ft2019 <- merge_foi_text(foitext2019)
rm(foitext2019)

ft2020 <- merge_foi_text(foitext2020)
rm(foitext2020)

ft2021 <- merge_foi_text(foitext2021)
rm(foitext2021)

ft2022 <- merge_foi_text(foitext2022)
rm(foitext2022)

# Combining the selected columns from all years into a single dataframe
combined_foitext <- bind_rows(ft2018, ft2019, ft2020, ft2021, ft2022)

#Removing the files for memory efficiency
rm(ft2018, ft2019, ft2020, ft2021, ft2022)

final_df <- merge(combined_devices, combined_foitext, by = "MDR_REPORT_KEY", all.x = TRUE)

# Function to clean FOI_TEXT, remove starting patterns, and handle encoding issues
clean_foi_text <- function(text) {
  # Ensuring text is in a recognizable encoding
  text <- iconv(text, to = "UTF-8", sub = "")
  # Removing the starting patterns
  text <- gsub("^\\(B\\)\\(4\\): ", "", text)
  text <- gsub("^\\(B\\)\\(4\\)\\. \\(B\\)\\(6\\)\\. ", "", text)
  text <- gsub("^\\(B\\)\\(4\\)\\. \\(B\\)\\(4\\)\\. ", "", text)
  text <- gsub("^\\(B\\)\\(4\\)\\. - ", "", text)
  text <- gsub("^\\(B\\)\\(4\\)\\. ", "", text)
  text <- gsub("^\\(B\\)\\(4\\)- ", "", text)
  text <- gsub("^\\(B\\)\\(4\\) - ", "", text)
  text <- gsub("^\\(B\\)\\(4\\)  ", "", text)
  text <- gsub("^\\(B\\)\\(4\\) ", "", text)
  text <- gsub("^\\(B\\)\\(6\\) - ", "", text)
  text <- gsub("^\\(B\\)\\(4\\. ", "", text)
  text <- gsub("^\\(B\\)\\(4\\)\\. ", "", text)
  text <- gsub("^\\(B\\)\\(6\\)  ", "", text)
  text <- gsub("^\\(B\\)\\(4\\)\\.", "", text)
  text <- gsub("^\\(B\\)\\(6\\)\\. ", "", text)
  text <- gsub("^\\(B\\)\\(4\\): ", "", text)
  text <- gsub("^\\(B\\)\\(4\\) - ", "", text)
  text <- gsub("^\\(B\\)\\(4\\) ", "", text)
  text <- gsub("^\\(B\\)\\(6\\) ", "", text)
  text <- gsub("^\\(B\\)\\(4\\)$", "", text)
  text <- gsub("^\\(B\\)\\(6\\)- ", "", text)
  text <- gsub("^\\(B\\)\\(4\\), ", "", text)
  text <- gsub("^\\(B\\)\\(4\\) - ", "", text)
  # Removing non-printable characters
  text <- gsub("[^[:print:]]", "", text)
  # Removing leading spaces
  text <- gsub("^\\s+", "", text)
  return(text)
}

# Applying the function to clean FOI_TEXT column and store in a new variable
cleaned_foitext <- final_df
cleaned_foitext$FOI_TEXT <- sapply(cleaned_foitext$FOI_TEXT, clean_foi_text, USE.NAMES = FALSE)

entries_with_parenthesis <- cleaned_foitext[grep("^\\(", cleaned_foitext$FOI_TEXT), ]
cleaned_foitext <- cleaned_foitext[-grep("^\\(", cleaned_foitext$FOI_TEXT), ]

# Exporting our final data
write.csv(cleaned_foitext, "C:/Project data Final/Project data Final/cleaned_foi_and_dev.csv", row.names = FALSE)
