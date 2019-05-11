library(ggplot2)
library(dplyr)
library(tidyr)

dat <- read.table(text = "    pos.1 pos.2 pos.pre-ultim pos.ultim
1   78  78  86  92
2   58  70  62  66
3   88 101  95  83
4   71  64  54  59
5   68  68  74  78
6   88  70  80  73",sep = "", header = TRUE)

total = sum(dat$pos.1)
total
# Add an id variable for the filled regions and reshape
datm <- dat %>% mutate(ind = factor(row_number())) %>% gather(variable, value, -ind)
levels(datm$ind) <- c('S','T','O','B','I','N')
ggplot(datm, aes(x = variable, y = value, fill = ind)) + 
  geom_bar(position = "fill",stat = "identity") +
  scale_y_continuous(labels = scales::percent_format()) +
  geom_text(aes(label = round(value/total, 3)), position = position_fill(vjust = 0.5)) +
  xlab("position in motif") +
  ylab("Procentage")
