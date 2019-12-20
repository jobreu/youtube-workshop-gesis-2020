if (!require(easypackages)) install.packages("easypackages")
library(easypackages)

packages("tidyverse",
         "lubridate",
         "hadley/emo",
         "tuber",
         "dill/emoGG",
         "quanteda",
         prompt = F)