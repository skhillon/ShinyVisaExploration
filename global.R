visa <- read_csv("visas.csv")

MIN.WAGE <- min(visa$PREVAILING_WAGE)
MAX.WAGE <- max(visa$PREVAILING_WAGE)

MIN.YEAR <- min(visa$YEAR)
MAX.YEAR <- max(visa$YEAR)
