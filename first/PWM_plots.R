library(ggplot2)
library(dplyr)
library(tidyr)
df <- read.table('/home/nikita/Documents/work/git_projects/GenomeAssembly/first/SISII_df.tsv', sep='\t')
df
dat <- read.table(text = "    pos.1 pos.2 pos.pre-ultim pos.ultim
1  6  7  9  8
2 20 21 30 23
3 10  8  5  7
4 19 22 15 20
5 18 23 22 22
6 13  5  5  6",sep = "", header = TRUE)

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
