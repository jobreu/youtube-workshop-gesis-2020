# install Stuff
install.packages("tuber")
install.packages("httr")
library(tuber)

# ONLY FOR UBUNTU!
httr::set_config(httr::config(ssl_verifypeer = 0L))


# Authentification
appID <- "278579024150-6rbfn7qo7sf12n3mgotjkpn16fhbf1vj.apps.googleusercontent.com" # Insert your own app ID here
appSecret <- "FO9lUFTBfHnY1VawcVBzzI_e" # insert your own app Secret here

# When running this line, there will be a prompt in the console asking you to save the access token in a file
# select "No" by entering 2 in the console and hitting enter.
# Afterwards, a browser window should open, prompting you to log in with your Google account and to give permissions
# After logging in, you can close the browser and return to R
yt_oauth(app_id = appID,app_secret = appSecret)

# test -> WORKS!
Comments_sample <- get_comment_threads(c(video_id = "DcJFdCmN98s"), max_results = 100)



############  Zerstörung der CDU

# getting video details
DetailsCDU <- get_video_details(video_id = "4Y1lZQsyuSQ", part = c("snippet"))
StatsCDU <- get_video_details(video_id = "4Y1lZQsyuSQ", part = c("statistics"))

# get "all" comments (30k comments fehlen! -> )
CommentsCDU <- get_all_comments(c(video_id = "4Y1lZQsyuSQ"))

# Comment Threads?
AllCDU <- get_comment_threads(filter = c(video_id = "4Y1lZQsyuSQ"), max_results = 101)

# get captions (Doesn' work? <- Not Found) # TRY AGAIN
list_caption_tracks(video_id = "J5LodnKnLYU")


CapsKG <- get_captions(id = "J5LodnKnLYU")
get_captions(id = "y3ElXcEME3lSISz6izkWVT5GvxjPu8pA")

# get related vidos
RelVidsCDU <- get_related_videos(video_id = "4Y1lZQsyuSQ")

# get video statistics
Stats2CDU <- get_stats(video_id = "4Y1lZQsyuSQ")

# get channel subscriptions (Doesn't work? -> Forbidden) You can only see your own subscribers
SubsCDU <- get_subscriptions(filter = c(channel_id = "UCwRH985XgMYXQ6NxXDo8npw"))

# Comment threads (Doesn't Work -> Forbidden?)
test <- get_comment_threads(filter = c(video_id = "N708P-A45D0"), max_results = 101)