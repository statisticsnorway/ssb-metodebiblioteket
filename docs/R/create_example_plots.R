# Create example plots

#### LmImpute ####
mydata <-data.frame(workers = runif(100) * 100)
mydata$turnover = runif(100) * 100 + mydata$workers
                 
library(ggplot2)
png(file="../pictures/regression.png")
ggplot(mydata, aes(x=workers, y=turnover)) + 
  geom_point(color='blue') +
  geom_smooth(method = 'lm')
dev.off()

#### heirarchy ####
library(DiagrammeR)
grViz("
  digraph {

  node[shape=box, width = 4, height = 1]

  blank_1 [label = '',color = white];
  President;
  blank_2 [label = '',color = white];

  blank_3[label = '', width = 0.01, height = 0.01];
  blank_4[label = '', width = 0.01, height = 0.01];
  blank_5[label = '', width = 0.01, height = 0.01];

  Fun1;
  Fun2;
  Fun3;

  {rank = same; blank_1 President blank_2}
  {rank = same; blank_3 blank_4 blank_5}
  {rank = same; Fun1 Fun2 Fun3}

  blank_1 -> President [dir = none, color = White]
  President -> blank_2 [dir = none, color = White]
  President -> blank_4 [dir = none]
  blank_1 -> blank_3 [dir = none, color = White]
  blank_2 -> blank_5 [dir = none, color = White]
  blank_3 -> blank_4 [dir = none]
  blank_4 -> blank_5 [dir = none]
  blank_3 -> Fun1
  blank_4 -> Fun2
  blank_5 -> Fun3

   }
 ")