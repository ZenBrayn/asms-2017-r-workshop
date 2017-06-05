#==================
# Author: R.Benz
# Date: 05/08/2017
# Purpose: create a mock data file listing sample attributes.  
#          Used for ASMS 2017 R Workshop Example #1.
#

library(stringr)
library(tidyverse)

set.seed(654321)

#=== file parameters
# number of samples in the list
n_samp <- 216


#== The attributes file will contain the following columns
# sample barcode
# sample name (a mix of site, gender, age)
# sample collection date
# treatment condition {treatment_1, treatment_2, treatment_3}
# sample collection site {site_1, site_2}

# sample barcode (6 digit integer)
# This is a mix of a text prefix and a number
# we'll just randomly generate the numbers
id_nums <- sample(100000:999999, n_samp, replace = FALSE)
sample_barcodes <- paste0("SAMP-RND", id_nums)


# sample name
# This is a combo of the collection sites, gender, age
collection_sites <- sort(rep(c("site_1", "site_2"), n_samp / 2))
genders <- rep(c("M", "F"), n_samp / 2)
ages <- sample(30:80, n_samp, replace = TRUE)
sample_names <- paste0(collection_sites, "-", genders, "-", ages)


# sample collection date
# collection over 2 months (jan and feb 2017)
jan_dates <- paste0("2017-01-", str_pad(1:31, width = 2, side = "left", pad = "0"))
feb_dates <- paste0("2017-02-", str_pad(1:28, width = 2, side = "left", pad = "0"))
all_dates <- c(jan_dates, feb_dates)
collection_dates <- sample(all_dates, n_samp, replace = TRUE)


# treatment condition
treatments <- rep(c("treatment_1", "treatment_2", "treatment_3"), n_samp / 3)


#== The combined data frame
out_df <- data.frame(barcode = sample_barcodes,
                     sample_name = sample_names,
                     collection_date = collection_dates,
                     treatment = treatments,
                     site = collection_sites,
                     stringsAsFactors = FALSE)

out_df <- out_df %>%
  arrange(site, collection_date)

#== Make some "mistakes
# Now we'll make some mistakes in the data frame
# to find and correct during the tidy phase

# 1. duplicate an entry
idx_sel <- sample(1:nrow(out_df), 1)
out_df <- rbind(out_df, out_df[idx_sel,])

# 2. swap 3 sites, difference between site col and sample_name
idx_sel <- sample(1:nrow(out_df), 3)
out_df[idx_sel, "site"] <- ifelse(out_df[idx_sel, "site"] == "site_1", "site_2", "site_1")

# 3. add a typo to 1 of the barcodes; RDN -> RNG
idx_sel <- sample(1:nrow(out_df), 1)
out_df[idx_sel, "barcode"] <- str_replace(out_df[idx_sel, "barcode"], "D", "G")


# Write out the final data file 
# (with the errors we'll later find and correct)
write.table(out_df, "input_data/sample_attributes_with_errors.csv", row.names = FALSE, sep = ",")




