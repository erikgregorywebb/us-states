library(tidyverse)

# download
url = 'https://raw.githubusercontent.com/erikgregorywebb/us-states/master/data/governors.csv'
download.file(url, 'governors.csv')

# import
raw = read_csv('governors.csv')
glimpse(raw)

# clean
governors = raw %>%
  filter(year >= 2000) %>% 
  filter(party %in% c('Republican', 'Democrat', 'Independent')) %>%
  filter(state != 'American Samoa' & state != 'Northern Mariana Islands' 
         & state != 'Puerto Rico' & state != 'Guam' & state != 'Virgin Islands')

# ratio by state
governors %>%
  group_by(state, party) %>% count() %>%
  spread(party, n, fill = 0) %>%
  mutate(total = Republican + Democrat + Independent) %>%
  mutate(ratio_rep = Republican / total) %>%
  ggplot(., aes(x = ratio_rep, y = reorder(state, ratio_rep))) + geom_point()
