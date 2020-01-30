if (!require(easypackages)) install.packages("easypackages")

easypackages::packages("tidyverse",
                       "devtools",
                       "tuber",
                       "quanteda",
                       "qdapRegex",
                       "tm",
                       "stm",
                       "syuzhet",
                       "lexicon",
                       "keyring",
                       "hadley/emo",
                       "dill/emoGG",
                       "fkeck/subtools",
                       prompt = F)
