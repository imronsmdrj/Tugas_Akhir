library(ggplot2) #library untuk menampilkan chart

head(dataset) #untuk menampilkan 5 data teratas

pairs(dataset[1:3]) #untuk melihat korelasi antar variabel

cor(dataset) #untuk melihat keterhubungan antara variabel dependen dengan variabel independen dilihat dari bentuk nilai diagonalnya

#install.packages("foreach")

model <- lm(pendapatan ~ jumlah_pelanggan + jumlah_produk, dataset) #proses pengolahan data menggunakan fungsi lm()

spend_value <- predict(model, dataset) #proses untuk melakukan prediksi dari model yang telah diolah pada tahap sebelumnya

spend_value #untuk menampilkan hasil prediksi tersebut

summary(model) #untuk menampilkan hasil proses dari pengolahan dengan fungsi lm()

#untuk menampilkan hasil dalam bentuk chart
qplot(jumlah_pelanggan, pendapatan, data = dataset, geom = c("point", "smooth")) #(x, y, data frame)

qplot(jumlah_produk, pendapatan, data = dataset, geom = c("point", "smooth"))

ggplot(dataset, aes(x=pendapatan, y=jumlah_produk)) + geom_line(colour = "red")

ggplot(dataset, aes(x=pendapatan, y=jumlah_pelanggan)) + geom_line(colour = "orange")