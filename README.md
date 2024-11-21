# Dental Implant Adverse Event Analysis

This repository contains code and resources for analyzing adverse events related to dental implants, focusing on the impact of the COVID-19 pandemic. The project uses data from the FDA's Medical Device Reporting (MDR) system, including device details, adverse event narratives, and metadata. The main goal is to provide insights into the trends, safety, and effectiveness of dental implants before and after the pandemic using data science and NLP techniques.

## Repository Overview

This repository is organized into two main sections:
1. **Data Preprocessing**: Scripts and functions for initial data cleaning, merging, and transformation.
2. **Project Analysis**: Core analysis using preprocessed data to evaluate adverse events and identify significant trends related to dental implants.

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
- `Final_Research_Dataset.csv`: Final processed and merged dataset.

---

## Part 2: Project Analysis

### Prerequisites

To run the analysis scripts, ensure you have the following installed:

1. **Python (3.8 or higher)**
2. Required Python packages:
   - `pandas`
   - `seaborn`
   - `matplotlib`
   - `nltk`
   - `wordcloud`
   - `textblob`
   - `tabulate`
   - `fuzzywuzzy`
   - `transformers`
   
You can install these packages using the following command:

```bash
pip install pandas seaborn matplotlib nltk wordcloud textblob tabulate fuzzywuzzy transformers
```

3. Download necessary NLTK resources by running:

```python
import nltk
nltk.download('punkt')
nltk.download('wordnet')
nltk.download('omw-1.4')
nltk.download('stopwords')
nltk.download('vader_lexicon')
```

4. Ensure your dataset files (`Final_Research_Dataset.csv` and any other required files) are in the correct path specified in the scripts.

---

### Objective

The analysis aims to extract actionable insights from FDA Medical Device Reporting (MDR) text data, focusing on adverse events related to dental implants. The analysis emphasizes:
- Identifying trends and patterns in adverse events before and after the COVID-19 pandemic.
- Classifying events into predefined categories using NLP techniques and a local language model.
- Evaluating the sentiment of narratives associated with adverse events.

### Methodology

The analysis is divided into several stages, detailed below:

#### 1. **Data Exploration and Visualization**
   - **Dataset Overview**: The dataset includes multiple attributes such as device details, event narratives, and metadata spanning several years.
   - **Visualization**: Distribution of adverse events was visualized over time, highlighting annual and quarterly trends using bar plots and line graphs.
   - **Yearly and Quarterly Trends**: Adverse event counts are grouped by year and quarter to observe variations across time.

#### 2. **Text Preprocessing and Feature Engineering**
   - **Text Cleaning**: Performed lemmatization and removal of stop words to standardize the textual data.
   - **Keyword Extraction**: Extracted the most common keywords related to dental implant adverse events using frequency analysis and word clouds.
   - **Sentiment Analysis**: Conducted sentiment analysis on the narratives using TextBlob to categorize positive, negative, and neutral sentiments.

#### 3. **Event Classification**
   - Events were classified into predefined categories (e.g., Pain, Failure, Success, Complications) based on keyword matching and sentiment polarity.
   - Leveraged **EleutherAI/gpt-neo-1.3B**, a local language model, to classify events and provide contextual understanding for more accurate categorization.
   - Multiple classification methods were employed:
     - **Basic Keyword Matching**: Events classified purely based on keyword frequency.
     - **Sentiment-Informed Classification**: Used sentiment polarity to resolve ties or ambiguities in classification.
     - **LLM-Based Classification**: Employed the local LLM model to provide deeper insights into event severity and context.

#### 4. **Comparison of Classification Methods**
   - Summarized event classification results across methods to identify the best approach.
   - Created comparison tables and visualizations to showcase differences in classification outcomes.

### Key Findings

- **Impact of COVID-19**: A noticeable shift in adverse event patterns and frequencies before and after the pandemic.
- **Dominant Categories**: Categories such as Failure were predominant, while Stress and Implant Removal had lower occurrences.
- **Sentiment Trends**: Positive sentiment often correlated with successful treatment narratives, while negative sentiment highlighted failures and complications.

### Outputs

#### Plots and Visualizations:
1. **Yearly and Quarterly Event Distribution**: Stacked bar plots and line graphs for trend analysis.
2. **Word Clouds**: Visual representation of top keywords in adverse event narratives.
3. **Category-Wise Analysis**: Pie charts and bar plots showing the distribution of adverse event types.


### Files
- **`Project_Analysis.ipynb`**: Detailed project notebook.

---

## Future Work

1. **Model Enhancement**:
   - Integrate advanced NLP models like BERT for finer-grained text analysis.
   - Extend LLM usage with more specialized training for dental implant data.

2. **Broader Applications**:
   - Analyze other medical devices for comprehensive safety trend evaluation.
   - Collaborate with healthcare professionals to validate findings and implement actionable insights.

3. **Interactive Dashboards**:
   - Develop dashboards for dynamic visualization of trends and insights.

---

## Acknowledgments

Special thanks to the University of Adelaide and my supervisor, Dr. Indu Bala, for her guidance and support.

---

## Contact

Feel free to report any issues or contribute to this project by submitting a pull request.
```
