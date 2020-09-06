library(GA) #library untuk memproses data menggunakan Genetic Algorithms
library(ggplot2) #library untuk menampilkan hasil dalam bentuk chart

#rastrigin ini untuk menjelaskan rumus yang akan dicari nilai optimasinya
Rastrigin <- function(x1, x2)
{
  y = 38698.09 + x1*9.01 + x2*14438.94
}

#Untuk mengurutkan angka bebas dari -5 - 5 dengan tambahan nilai sebesar 0.1
x1 <- x2 <- seq(-5, 5, by = 0.1) 

#untuk menerapkan fungsi array pada variabel
f <- outer(x1, x2, Rastrigin)

persp3D(x1, x2, f, theta = 50, phi = 20, col.palette = bl2gr.colors)

GA <- ga(type = "real-valued", pcrossover = 0.1, fitness = function(x) -Rastrigin(x[1], x[2]),
         lower = c(15, 18), upper = c(18, 19),
         seed = 123, elitism = 30, popSize = 50, maxiter = 100, run = 30)

summary(GA)

plot(GA)

(GA@population)
