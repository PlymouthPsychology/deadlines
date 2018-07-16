library(bizdays)

# system("curl http://www.dmo.gov.uk/docs/giltsmarket/formulae/UKbankholidays.xls > hols.xls")
hols <- read_excel("bizdays/hols.xls") %>% 
  mutate(dt=as.Date(`UK BANK HOLIDAYS`))


student_christmas_vac <- function(year) seq(from=XMAS_START, to=XMAS_END, by=1)

staff_christmas_vac <- function(year) seq(from=dmy(paste0("24/12/", year)), to=dmy(paste0("24/12/", year))+days(7), by=1)

student_easter_vac <- function(year) seq(from=EASTER_START, to=EASTER_END, by=1)

create.calendar("Students", 
                holidays = c(
                  hols$dt,
                  student_christmas_vac(CURRENT_YEAR),
                  student_easter_vac(CURRENT_YEAR+1)
                ), 
                start.date = as.Date("2015/12/1"),
                end.date = as.Date("2041/12/1"),
                weekdays = c("saturday", "sunday")) # note weekdays specifies non-weekdays


create.calendar("Staff", 
                holidays = c(
                  hols$dt,
                  staff_christmas_vac(CURRENT_YEAR)
                ), 
                start.date = as.Date("2015/12/1"),
                end.date = as.Date("2041/12/1"),
                weekdays = c("saturday", "sunday")) # note weekdays specifies non-weekdays


# utilities
diffdays <- function(a,b) {
  a%--%b %>% as.duration %>% as.numeric(., "days")
}

pdate <- function(d) format(d, "%a %d %B %Y")
next_student_bizday <- function(d) bizdays::adjust.next(d, "Students")
next_staff_bizday <- function(d) bizdays::adjust.next(d, "Staff")
nearest_thursday <- function(d) floor_date(d, 'week') + days(4)