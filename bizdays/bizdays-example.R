library(bizdays)
library(dplyr)

# system("curl http://www.dmo.gov.uk/docs/giltsmarket/formulae/UKbankholidays.xls > hols.xls")
hols <- read_excel("hols.xls") %>% 
  mutate(dt=as.Date(`UK BANK HOLIDAYS`))
mkxmas <- function(xmaseve) c(seq.Date(xmaseve, xmaseve+7, 1))
xmasdates <- Reduce(c, lapply(as.Date(paste0(2016:2040, "/12/24")), mkxmas))

all_hols <- c(hols$dt, xmasdates) %>% sort

create.calendar("PlymouthUniversity", 
                holidays = all_hols, 
                start.date = as.Date("2015/12/1"),
                end.date = as.Date("2041/12/1"),
                weekdays = c("saturday", "sunday")) # note weekdays specifies non-weekdays

is.bizday(Sys.Date(), "PlymouthUniversity")
is.bizday(Sys.Date()+1, "PlymouthUniversity")
is.bizday(Sys.Date()+2, "PlymouthUniversity")
is.bizday(as.Date("2020/12/28"), "PlymouthUniversity")