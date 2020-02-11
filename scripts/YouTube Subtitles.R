install.packages("devtools") # GitHub installation
install_github("soodoku/tuber") # YouTube data
install_github("fkeck/subtools") # subtitle processing
install.packages("stm") # topic modelling

library(devtools)
library(tuber)
library(subtools)
library(stm)

appID <- "" # Insert your own app Id here (OAuth 2.0 Client ID created for your project via the Google Developers platform)
appSecret <- "" # insert your own app Secret here (Client key created for your project via the Google Developers platform)
# NB: Be careful to NOT share these credentials with anyone else whom you don't want to be able to use this account.

## Upon running this line, there will be a prompt in the console asking you to save the access token in a file
## Select "No" by entering 2 in the console and hitting enter.
## Afterwards, a browser window should open, prompting you to log in with your Google account
## After logging in, you can close the browser and return to R
yt_oauth(appID,appSecret)

#### Extracting Subtitles ####
# Gets video info including the subtitles id
Caption_list1 <- list_caption_tracks(part = "snippet", video_id = "nI_OfkQOG6Q") # Video with 1 sub
Caption_list2 <- list_caption_tracks(part = "snippet", video_id = "C0AY3AN5kI4") # video with 1 automatically created sub
Caption_list3 <- list_caption_tracks(part = "snippet", video_id = "3TNkWTRNNYE") # video with 2 subs -> 400 error
Caption_list4 <- list_caption_tracks(part = "snippet", video_id = "j93NnRLyym0") # ASR exists, but not selectable
Caption_list5 <- list_caption_tracks(part = "snippet", video_id = "YgWgHRjv_Ps") # ARS exists, but no subs displayed
Caption_list6 <- list_caption_tracks(part = "snippet", video_id = "OuO135_5Rxk") # ARS exists, but no subs displayed

# Example with Video 3
# Extracts the id and converts it to string
ID_ASR <- toString(Caption_list3[1,"id"]) # automatically created subtitle
ID_DE <- toString(Caption_list3[2,"id"]) # German subtitle

# Retrieves the subtitles (format=raw)
Text_ASR <- rawToChar(get_captions(id = ID_ASR, format = "sbv")) # automatically created subtitle
Text_DE <- rawToChar(get_captions(id = ID_DE, format = "sbv")) # German subtitle (translated per default)
Text_GER <- rawToChar(get_captions(id = ID_DE, format = "sbv", lang = "de")) # German subtitle (in German)

# Known Issues
# 1. Videos can have more than one subtitle for the same language
# 2. If the video has disabled third party contributions for the subtitles, the query will result in a 403 error
#  https://stackoverflow.com/questions/30653865/downloading-captions-always-returns-a-403

# Writes readable subtitles to file because subtools cannot read from variables
write(Text_ASR, file = "Captions_ASR.sbv", sep="\n") 
write(Text_DE, file = "Captions_DE.sbv", sep="\n")
write(Text_GER, file = "Captions_GER.sbv", sep="\n")

# Reads the subtitles file and converts it into a subtools object
Subs_ASR <- read_subtitles("Captions_ASR.sbv", format = "subviewer") 
Subs_DE <- read_subtitles("Captions_DE.sbv", format = "subviewer")
Subs_GER <- read_subtitles("Captions_GER.sbv", format = "subviewer")

# Retrieves text data from the subtools object
Subtext_ASR <- get_raw_text(Subs_ASR)
Subtext_DE <- get_raw_text(Subs_DE)
Subtext_GER <- get_raw_text(Subs_GER)

#### Processing Subtitles (could also be done with Quanteda) ####
processed <- textProcessor(Subtext, metadata = NULL, lowercase = TRUE, removestopwords = TRUE, removenumbers = TRUE, 
                          removepunctuation = TRUE, stem = TRUE, wordLengths = c(3, Inf), sparselevel = 1, language = "en", 
                          verbose = TRUE, onlycharacter = FALSE, striphtml = FALSE, customstopwords = NULL) # Cleaning up and converting to stm format
out <- prepDocuments(processed$documents, processed$vocab, processed$meta, lower.thresh = 0,
                     upper.thresh = Inf, subsample = NULL, verbose = TRUE) # Preparing processed texts; if there is more than one document, adjust lower.thresh