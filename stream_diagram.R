# Vamos fazer um Stream Diagram a partir de dados no formato:
#
#    milestone  status_dt      plan_dt
#       m1       2020-11-10   2020-12-23
#       m1       2020-12-10   2020-12-23
#       m2       2020-11-10   2021-01-05
#

library(ggplot2)
library(chron)
library(readr)
library(dplyr)

milestones <- read_csv2(file = "./data-prj/milestones.csv")
milestones <- milestones %>% 
  mutate(status_dt = as.numeric(as.Date(status_dt)),
         plan_dt = as.Date(plan_dt))

(ggplot(milestones,
        aes(x = plan_dt,
            y = status_dt,
            color = milestone,
            group = milestone)) +
    #geom_hline(yintercept = milestones$status_dt) +
    geom_line() +
    geom_point(shape = 23) +
    labs(x = "Data Prevista e/ou Realizada",
         y = "Data de Avaliação",
         title = "Milestones do Projeto",
         subtitle = "Status Atual: 2021-03-10") +
    theme_minimal() +
    theme(axis.text.x = element_text(angle = 45, hjust = .1, vjust = .5)) +
    scale_y_reverse(label=function(x) strftime(chron(x), "%Y-%m-%d")) +
    scale_x_date(position = "top", # coloca o eixo x no topo
               expand = c(0, 10), # acrescenta um espaço de "0 * range + 10 * unidade" nas laterais do gráfico
               #breaks = as.Date(c("2020-11-01", "2020-12-01", "2021-01-01", "2021-02-01")),
               #minor_breaks = as.Date(c("2020-11-15", "2020-12-15", "2021-01-15"))
               #date_breaks = "1 month",
               #date_minor_breaks = "15 days",
               date_labels = "%y-%m-%d"
               #date_labels = "%y (%B)" # Code	Meaning
               # %S	second (00-59)
               # %M	minute (00-59)
               # %l	hour, in 12-hour clock (1-12)
               # %I	hour, in 12-hour clock (01-12)
               # %H	hour, in 24-hour clock (01-24)
               # %a	day of the week, abbreviated (Mon-Sun)
               # %A	day of the week, full (Monday-Sunday)
               # %e	day of the month (1-31)
               # %d	day of the month (01-31)
               # %m	month, numeric (01-12)
               # %b	month, abbreviated (Jan-Dec)
               # %B	month, full (January-December)
               # %y	year, without century (00-99)
               # %Y	year, with century (0000-9999)
    )
)

