library(GA) #library untuk memproses data menggunakan Genetic Algorithms
library(ggplot2) #library untuk menampilkan hasil dalam bentuk chart

#rastrigin ini untuk menjelaskan rumus yang akan dicari nilai optimasinya
Rastrigin <- function(x1, x2)
{
  y = 38698.09 + x1*9.01 + x2*14438.94
}

x1 <- x2 <- seq(-2, 2, by = 0.5)

f <- outer(x1, x2, Rastrigin)

persp3D(x1, x2, f, theta = 50, phi = 20, col.palette = bl2gr.colors)

filled.contour(x1, x2, f, color.palette = bl2gr.colors)

GA <- ga(type = "real-valued", pcrossover = 0.8, fitness = function(x) -Rastrigin(x[1], x[2]),
         lower = c(-1, -1), upper = c(5.12, 5.12),
         seed = 123, elitism = 50, popSize = 300, maxiter = 300, run = 30)

summary(GA)

plot(GA)

(GA@population)
