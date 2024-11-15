pacman::p_load(tidyverse,readr,writexl)

folder_path <- "U:\\Downloads"

loaded_cleaned_foitext <- read.csv("U:\\Downloads\\cleaned_foi_and_dev.csv")
mastercsv <- read.csv("U:\\Downloads\\mdrfoitru2023.csv")

final_dataset <- merge(loaded_cleaned_foitext, mastercsv, by = "MDR_REPORT_KEY", all.x = TRUE)

remove_unwanted_columns <- function(df) {
  df$MANUFACTURER_D_ADDRESS_1 <- NULL
  df$MANUFACTURER_D_ADDRESS_2 <- NULL
  df$MANUFACTURER_D_STATE_CODE <- NULL
  df$MANUFACTURER_D_ZIP_CODE <- NULL
  df$MANUFACTURER_D_ZIP_CODE_EXT <- NULL
  df$MANUFACTURER_D_COUNTRY_CODE <- NULL
  df$MANUFACTURER_D_POSTAL_CODE <- NULL
  return(df)
}

# Apply the function to the final dataset
final_dataset <- remove_unwanted_columns(final_dataset)

# Save the final dataset to a new CSV file using write.csv
write.csv(final_dataset, "U:\\Downloads\\final_merged_dataset.csv", row.names = FALSE)

distinct_report_keys <- length(unique(final_dataset$MDR_REPORT_KEY))
print(paste("Number of distinct MDR_REPORT_KEY values:", distinct_report_keys))
