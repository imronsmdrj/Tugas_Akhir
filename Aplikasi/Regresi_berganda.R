library(ggplot2)

head(dataset)

pairs(dataset[1:3])

cor(dataset)

#install.packages("foreach")

model <- lm(pendapatan ~ jumlah_pelanggan + jumlah_produk, dataset)

spend_value <- predict(model, dataset)

spend_value

summary(model)

qplot(jumlah_pelanggan, pendapatan, data = dataset, geom = c("point", "smooth")) #(x, y, data frame)

qplot(jumlah_produk, pendapatan, data = dataset, geom = c("point", "smooth"))

ggplot(dataset, aes(x=pendapatan, y=jumlah_produk)) + geom_line(colour = "red")

ggplot(dataset, aes(x=pendapatan, y=jumlah_pelanggan)) + geom_line(colour = "orange")