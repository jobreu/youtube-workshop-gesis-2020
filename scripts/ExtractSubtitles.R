install.packages("stm") # topic modelling 
install.packages("tuber") # YouTube data
install_github("fkeck/subtools") # subtitle processing

library(stm)
library(subtools)
library(tuber)


appID <- "" # Insert your own app Id here (OAuth 2.0 Client ID created for your project via the Google Developers platform)
appSecret <- "" # insert your own app Secret here (Client key created for your project via the Google Developers platform)
# NB: Be careful to NOT share these credentials with anyone else whom you don't want to be able to use this account.

## Upon running this line, there will be a prompt in the console asking you to save the access token in a file
## select "No" by entering 2 in the console and hitting enter.
## Afterwards, a browser window should open, prompting you to log in with your Google account
## After logging in, you can close the browser and return to R
yt_oauth(appID,appSecret)

                                #### Extracting Subtitles ####  Yd0dTaepyyY PjpS9CftpVo nI_OfkQOG6Q C0AY3AN5kI4
# gets video info including the subtitles id
#Caption_list <- list_caption_tracks(part = "snippet", video_id = "nI_OfkQOG6Q") # Video with 1 sub
#Caption_list <- list_caption_tracks(part = "snippet", video_id = "C0AY3AN5kI4") # video with 1 automatically created sub
#Caption_list <- list_caption_tracks(part = "snippet", video_id = "3TNkWTRNNYE") # video with 2 subs -> 400 error
#Caption_list <- list_caption_tracks(part = "snippet", video_id = "j93NnRLyym0") # ASR exists, but not selectable
#Caption_list <- list_caption_tracks(part = "snippet", video_id = "YgWgHRjv_Ps") # ARS exists, but no subs displayed
Caption_list <- list_caption_tracks(part = "snippet", video_id = "OuO135_5Rxk") # ARS exists, but no subs displayed

ID <- toString(Caption_list[1,"id"]) # extracts the id and converts it to string
Text <- rawToChar(get_captions(id = ID, format = "sbv")) # retrieves the subtitles (format=raw)

# Known Issues
# 1. Videos can have no subtitles, not even automatically created subtitles
# 2. Videos can have more than one subtitle for the same language
# 3. If the video has disabled third party contributions for the subtitles, the query will result in a 403 error
#  https://stackoverflow.com/questions/30653865/downloading-captions-always-returns-a-403

write(Text, file = "Captions.sbv", sep="\n") #writes readable subtitles to file because subtools cannot read from variables
# rm (Text)
Subs <- read_subtitles("Captions.sbv", format = "subviewer") # reads the subtitles file and converts it into a subtools object
Subtext <- get_raw_text(Subs) # retrieves text data from the subtools object

                                #### Processing Subtitles ####
processed <- textProcessor(Subtext, metadata = NULL, lowercase = TRUE, removestopwords = TRUE, removenumbers = TRUE, 
                          removepunctuation = TRUE, stem = TRUE, wordLengths = c(3, Inf), sparselevel = 1, language = "en", 
                          verbose = TRUE, onlycharacter = FALSE, striphtml = FALSE, customstopwords = NULL) # Cleaning up and converting to stm format
out <- prepDocuments(processed$documents, processed$vocab, processed$meta, lower.thresh = 0,
                     upper.thresh = Inf, subsample = NULL, verbose = TRUE) # Preparing processed texts; if there is more than one document, adjust lower.thresh
