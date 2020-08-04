#Cara pertama
library(GA)

f <- function(x) abs(x)+cos(x)
curve(f, -20, 20)

fitness <- function(x) -f(x)
GA <- ga(type = "real-valued", fitness = fitness, lower = -20, upper = 20)

summary(GA)

plot(GA)

curve(f, -20, 20)
abline(v = GA@solution, lty = 3)


#Cara kedua
f <- function(x) (x^2+x)*cos(x) #-10 < x < 10
curve(f, -10, 10)

#write your own tracing function
monitor <- function(obj)
{
  curve(f, -10, 10, main = paste("iteration =", obj@iter))
  points(obj@population, obj@fitness, pch = 20, col = 2)
  rug(obj@population, col = 2)
  Sys.sleep(0.2)
}

GA <- ga(type = "real-valued", fitness = f, lower = -10, upper = 10, monitor = monitor)

GA <- ga(type = "real-valued", fitness = f, lower = -10, upper = 10, monitor = NULL)

summary(GA)

monitor(GA)
abline(v = GA@solution, lty = 3)


#Cara ketiga
Rastrigin <- function(x1, x2)
{
  y = x1*b1 + x2*b2 
}

x1 <- x2 <- seq(-5.12, 5.12, by = 0.1)
f <- outer(x1, x2, Rastrigin)
persp3D(x1, x2, f, theta = 50, phi = 20, col.palette = bl2gr.colors)
filled.contour(x1, x2, f, color.palette = bl2gr.colors)

GA <- ga(type = "real-valued", fitness = function(x) -Rastrigin(x[1], x[2]),
         lower = c(-5.12, -5.12), upper = c(5.12, 5.12),
         popSize = 50, maxiter = 100)

summary(GA)
plot(GA)



#Cara keempat
library(GA)

Rastrigin <- function(x1, x2)
{
  Sys.sleep(0.1)
  20 + x1^2 + x2^2 - 10*(cos(2*pi*x1) + cos(2*pi*x2))
}

system.time(GA1 <- ga(type = "real-valued",
                      fitness = function(x) -Rastrigin(x[1], x[2]),
                      lower = c(-5.12, -5.12), upper = c(5.12, 5.12),
                      popSize = 50, maxiter = 200, monitor = TRUE,
                      seed = 12345))

system.time(GA2 <- ga(type = "real-valued",
                      fitness = function(x) -Rastrigin(x[1], x[2]),
                      lower = c(-5.12, 05.12), upper = c(5.12, 5.12),
                      popSize = 50, maxiter = 200, monitor = TRUE,
                      seed = 12345, parallel = TRUE))








