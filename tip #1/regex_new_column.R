library(stringr)
library(magrittr)

regex_match_name <- function(pattern,group_names,string) {
  regex_group_names <- group_names %>% str_split(',') %>% .[[1]]
  matches <- str_match_all(as.character(string),pattern) %>%
    as.data.frame()
  names(matches) <- c(pattern,regex_group_names)
  return(matches)
}

output <- regex_match_name('to:(\\S+).*?from:(\\S+)','message_to,message_from',logs['V1']) %>%
  cbind(logs,.)
