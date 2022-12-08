##

library(rvest)
library(dplyr)
library(ggplot2)
#calcul du nombre de tableau retrouves dans Skysports
lien_sport = "https://www.skysports.com/world-cup-table"
data_sport = rvest::read_html(lien_sport)
data_sport
table_sport = rvest::html_table(data_sport)
length(table_sport)


# fonction qui permet de lire la page web et de compiler les différents tableaux en un seul data frame
f_pageweb<-function(){
  lien_sport = "https://www.skysports.com/world-cup-table"
  data_sport = rvest::read_html(lien_sport)
  table_sport = rvest::html_table(data_sport)
  Worldcup22 = do.call(rbind,list(table_sport[[1]],table_sport[[2]],table_sport[[3]],
                                  table_sport[[4]],table_sport[[5]],table_sport[[6]],
                                  table_sport[[7]],table_sport[[8]]))
  Worldcup22  = Worldcup22[,-3]
  Worldcup22 = Worldcup22  [,-10]
  return(Worldcup22)
}
df_stockage = f_pageweb()

# Réalisation d'un graphique en bâton avec les 10 équipes ayant le nombre de points le plus élevé.
str(df_stockage)
df_stockage%>%arrange(desc(Pts))%>%head(10)%>%
  ggplot(aes(y = Pts, x = Team))+
  geom_bar(stat = 'identity', fill ='blue') + theme_classic()
