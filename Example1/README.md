# Example #1: Data Cleaning, Tidying and Visualization

In this example, the data from a sample attributes files from a hypothetical study and a set of associated LC-MS worklists are cleaned, tidied and visualized.

* First the data from the attributes file are reviewed, and several data inconsistencies are revealed.
* These inconsistencies are fixed, and additional data tidying steps are performed.
* The worklist data are read from the source Excel spreadsheet across several individual sets, and are reviewed.
* The worklist data are then merged across the sheets to make a single data table.
* A final experimental attributes data set is then produced by merging the sample attributes and worklist data into a single table.
* Using the tidied data, exploratory data analysis and visualization is performed to better understand the nature and structure of the data, look for potential problems, and suggest new analysis questions to follow-up on.

## Scripts
1. ```01_generate_mock_data.R```: this script generates the mock data that is analyzed in the subsequent .Rmd documents.  The mock data has already been generated and is part of the repository so it does not need to be run in order for the other .Rmd scripts to work.
2. ```02_tidy_data.Rmd```: this .Rmd document tidies the mock data.
3. ```03_visualize_data.Rmd```: this .Rmd document generates visualizations of the data tided in the ```02_...``` script.
