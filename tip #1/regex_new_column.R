library(stringr)
library(magrittr)

# Define our variables
regex_pattern = 'to:(\\S+).*?from:(\\S+)'
regex_names = 'message_to,message_from'
column_name = 'Column1'

# Define our dataset
logs <- data.frame(
  Column1 = c(
    '00:05:36SYS.PLC Ipso Msg to:PortJHKIF from:PortNone cmd:Cmd2',
    '00:15:51SYS.HEATER  |0541|Msg to:PortManager from:PortIF cmd:Cmd1'
  )	
)

# Set up a function to return a dataframe of regex_matches with defined names
regex_match_name <- function(pattern,group_names,string) {
  regex_group_names <- group_names %>% str_split(',') %>% .[[1]]
  matches <- str_match_all(as.character(string),pattern) %>%
    as.data.frame()
  names(matches) <- c(pattern,regex_group_names)
  return(matches)
}

# Run function
output <- regex_match_name(
		regex_pattern,regex_names,logs[column_name]
		) %>% cbind(logs,.) #add new columns to original dataset
