if(!require("ggplot2")){
    install.packages("ggplot2")
    library("ggplot2")
}
if(!require("GGally")){
    install.packages("GGally")
    library("GGally")
}
library("ggplot2")
library("GGally")
library(cluster)
library(magrittr)
#zad1
nazwa <- 1:10
nazwa %<>% log2() %>% sin() %>% sum() %>% sqrt()
print(nazwa)
data(iris)
print(head(iris))
agg <- iris %>%
    aggregate(.~Species, ., mean)
print(agg)
#zad2
a <- ggplot(iris, aes(x = Sepal.Width)) +
    geom_histogram(aes(fill=Species, color = Species), bins=20) + 
    geom_vline(data=agg, aes(xintercept=Sepal.Width, color = Species), linetype="dashed") + 
    labs(x='x_axis', y='y_axis', title='title')
ggsave("/home/wykres1.jpg",plot=a)
#zad3
x <-iris[,1:4]
y <- iris[,5]
sum_sqr <- c()
for (i in 1:10){
    kmeans_result <- kmeans(x, i)
    sum_sqr <- append(sum_sqr, kmeans_result$tot.withinss)
}
a <- ggplot(data.frame(iteration = 1:length(sum_sqr), value = sum_sqr), aes(x=iteration, y=sum_sqr)) +
geom_line()
ggsave("/home/wykres2.jpg", plot=a)

kmeans_result <- kmeans(x,3)
a <- ggplot(iris, aes(x=Sepal.Width, y=Petal.Width, color=kmeans_result$cluster)) + geom_point()
ggsave("/home/wykres3.jpg", plot=a)

a <- ggplot(iris, aes(x=Sepal.Width, y=Petal.Width, color=Species)) + geom_point()
ggsave("/home/wykres4.jpg", plot=a)