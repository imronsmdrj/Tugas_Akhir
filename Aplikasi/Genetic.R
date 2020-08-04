library(GA)
library(ggplot2)

Rastrigin <- function(x1, x2)
{
  y = 566.04 + x1*8.96 + x2*19554.88
}

x1 <- x2 <- seq(-2, 2, by = 0.5)

f <- outer(x1, x2, Rastrigin)

persp3D(x1, x2, f, theta = 50, phi = 20, col.palette = bl2gr.colors)

filled.contour(x1, x2, f, color.palette = bl2gr.colors)

GA <- ga(type = "real-valued", pcrossover = 0.8, fitness = function(x) -Rastrigin(x[1], x[2]),
         lower = c(1, 1), upper = c(5, 5),
         popSize = 60, maxiter = 50)

summary(GA)

plot(GA)

(GA@population)
