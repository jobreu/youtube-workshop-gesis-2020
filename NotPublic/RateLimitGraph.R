# loading packages
library(ggplot2)
library(scales)

# data
RateLimits <- c(50000000,1000000,10000)
Dates <- as.Date(c("12/01/13","05/01/16","01/11/19"),"%m/%d/%y")
df <- cbind.data.frame(RateLimits,Dates)

# plot
ggplot(data = df, aes(x = Dates, y = RateLimits)) +
  geom_step(color = "black") +
  geom_point() +
  xlab("Timeline") +
  ylab("Ratelimit") +
  ggtitle("Reduction in YouTube API Rate Limits over time") +
# geom_rect(data = NULL,aes(xmin = as.Date("02/01/00","%m/%d/%y"),xmax=as.Date("12/01/13","%m/%d/%y"),ymin=10,ymax=50000000), fill = "red", alpha = 0.2)+
  expand_limits(x = c(as.Date("02/01/05","%m/%d/%y"),as.Date("12/01/20","%m/%d/%y")), y = c(0,1000000)) +
  scale_y_continuous(labels = comma) +
  scale_x_date(date_breaks = "years", date_minor_breaks = "months") +
  geom_vline(xintercept = as.Date("12/01/13","%m/%d/%y"), linetype = "dotted",color = "red", size = 1.5) +
  theme(axis.text.x = element_text(angle = 90)) +
  geom_text(aes(label = Dates),hjust = 0.0, vjust = -0.5)



