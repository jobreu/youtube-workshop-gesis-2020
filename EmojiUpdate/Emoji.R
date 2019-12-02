######## Simplifying Emoji Assignment


########## Setup

# check wd
getwd()

# packages
library(emoGG)
library(ggplot2)
library(quanteda)
library(emo)


######## General testing:

# Example (works)
ggplot(iris, aes(Sepal.Length, Sepal.Width, color = Species)) +
  geom_emoji(emoji = "1f337")

# Doesn't work (Error: Not Found)
Pic <- "1f337"
ggplot(iris, aes(Sepal.Length, Sepal.Width, color = Species)) +
  geom_emoji(emoji = Pic)


# Workaround
Pic <- "1f337"
ggplot(iris, aes(Sepal.Length, Sepal.Width, color = Species)) +
  do.call(geom_emoji, list(emoji = tolower("263A FE0F")))




####################### Applying to actual data

### loading data

# comments
load("ParsedCommentsUTF8.Rdata")

# Emoji Dictionary
Emojis <- as.data.frame(jis)

# reformat Emoji Dictionary format to fit to comments
Emojis[,4] <- gsub(" ","",Emojis[,4])
Emojis[,4] <- paste0("EMOJI_",Emojis[,4])
Emojis[,4] <- tolower(Emojis[,4])



#### Emoji DFM


# First, we need to correctly define missing values in the emoji variable
FormattedComments$Emoji[FormattedComments$Emoji == "NA"] <- NA

# next, we remove spaces at the end of the string
FormattedComments$Emoji <- substr(FormattedComments$Emoji, 1, nchar(FormattedComments$Emoji)-1)

# then we tokenize emoji descriptions (important for comments that contain more than one Emoji)
EmojiToks <- tokens(FormattedComments$Emoji)

# afterwards, we create an emoji frequency matrix, excluding "NA" as a term
EmojiDfm <- dfm(EmojiToks, remove = "NA")

# next, we list the most frequent emojis in the comments
EmojiFreq <- textstat_frequency(EmojiDfm)
head(EmojiFreq, n = 10) # you can pick a different value for n to choose the length of the most frequent Emojis table
# the variable docfreq indicates in how many comments the emoji appears









#### Visualizing by overall frequencies

# Sort by reverse frequency order (i.e., from most to least frequent)
EmojiFreq$feature <- with(EmojiFreq, reorder(feature, -frequency))

# plot
ggplot(head(EmojiFreq, n = 50), aes(x = feature, y = frequency)) + # you can change n to choose how many Emojis are plotted
  geom_point() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  labs(title = "Most frequent emojis", subtitle = "Schmoyoho - OH MY DAYUM ft. Daym Drops \nhttps://www.youtube.com/watch?v=DcJFdCmN98s")

# New  dynamic Mappings (Problems with mappings 5 and 10 because they consist of two strings <- This is why we need strsplit)
mapping1 <- do.call(geom_emoji,list(data = EmojiFreq[1,],emoji = strsplit(tolower(Emojis$runes[Emojis$name == as.character(EmojiFreq[1,]$feature)])," ")[[1]][1]))
mapping2 <- do.call(geom_emoji,list(data = EmojiFreq[2,],emoji = strsplit(tolower(Emojis$runes[Emojis$name == as.character(EmojiFreq[2,]$feature)])," ")[[1]][1]))
mapping3 <- do.call(geom_emoji,list(data = EmojiFreq[3,],emoji = strsplit(tolower(Emojis$runes[Emojis$name == as.character(EmojiFreq[3,]$feature)])," ")[[1]][1]))
mapping4 <- do.call(geom_emoji,list(data = EmojiFreq[4,],emoji = strsplit(tolower(Emojis$runes[Emojis$name == as.character(EmojiFreq[4,]$feature)])," ")[[1]][1]))
mapping5 <- do.call(geom_emoji,list(data = EmojiFreq[5,],emoji = strsplit(tolower(Emojis$runes[Emojis$name == as.character(EmojiFreq[5,]$feature)])," ")[[1]][1]))
mapping6 <- do.call(geom_emoji,list(data = EmojiFreq[6,],emoji = strsplit(tolower(Emojis$runes[Emojis$name == as.character(EmojiFreq[6,]$feature)])," ")[[1]][1]))
mapping7 <- do.call(geom_emoji,list(data = EmojiFreq[7,],emoji = strsplit(tolower(Emojis$runes[Emojis$name == as.character(EmojiFreq[7,]$feature)])," ")[[1]][1]))
mapping8 <- do.call(geom_emoji,list(data = EmojiFreq[8,],emoji = strsplit(tolower(Emojis$runes[Emojis$name == as.character(EmojiFreq[8,]$feature)])," ")[[1]][1]))
mapping9 <- do.call(geom_emoji,list(data = EmojiFreq[9,],emoji = strsplit(tolower(Emojis$runes[Emojis$name == as.character(EmojiFreq[9,]$feature)])," ")[[1]][1]))
mapping10 <- do.call(geom_emoji,list(data = EmojiFreq[10,],emoji = strsplit(tolower(Emojis$runes[Emojis$name == as.character(EmojiFreq[10,]$feature)])," ")[[1]][1]))

# Sort by reverse frequency order
EmojiFreq$feature <- with(EmojiFreq, reorder(feature, -frequency))

# Plot 10 most common Emojis using their graphical representation as points in the scatterplot
ggplot(EmojiFreq[1:10], aes(x = feature, y = frequency)) +
  geom_point() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  labs(title = "10 most frequent emojis", subtitle = "Schmoyoho - OH MY DAYUM ft. Daym Drops \nhttps://www.youtube.com/watch?v=DcJFdCmN98s") +
  mapping1 +
  mapping2 +
  mapping3 +
  mapping4 +
  mapping5 +
  mapping6 +
  mapping7 +
  mapping8 +
  mapping9 +
  mapping10