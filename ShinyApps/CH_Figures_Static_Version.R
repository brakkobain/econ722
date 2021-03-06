#This script replicates Figures 4.1 and 4.2 of Claeskens & Hjort (2008) - Model Selection and Model Averaging

#Figure 4.1 
mu <- seq(from = -0.5, to = 0.5, by = 0.001)

n <- 1000

pAIC <- pnorm(-sqrt(2) - sqrt(n) * mu) + (1 - pnorm(sqrt(2) - sqrt(n) * mu))  

pBIC <- pnorm(-sqrt(log(n)) - sqrt(n) * mu) + (1 - pnorm(sqrt(log(n)) - sqrt(n) * mu)) 

y.max <- max(max(pBIC), max(pAIC))
y.min <- min(min(pBIC), min(pAIC))
plot(mu, pAIC, ylim = c(y.min, y.max), xlab = expression(mu), ylab = 'Probability of Selecting M1', type = 'l', col = 'red', lwd = 2)
points(mu, pBIC, type = 'l', col = 'blue', lty = 2, lwd = 2)
legend('bottomright', legend = c('AIC', 'BIC'), lty = c(1,2), col = c('red', 'blue'), lwd = c(2,2))





#Figure 4.2
d.AIC <- function(n.T){return(2)}
d.BIC <- function(n.T){return(log(n.T))}
d.Hodge <- function(n.T){return(sqrt(n.T))}

risk <- function(n.T, mu, d.T){
  a <- -sqrt(d.T(n.T)) - sqrt(n.T) * mu
  b <- sqrt(d.T(n.T)) - sqrt(n.T) * mu
  first.term <- b * dnorm(b) - a * dnorm(a) 
  second.term <- (n.T * mu^2 - 1) * (pnorm(b) - pnorm(a))
  return(1 + first.term + second.term)
}

mu <- seq(from = -2, to = 2, by = 0.01)
sample.size <- 200


risk.mu <- cbind(risk(sample.size, mu, d.AIC), 
                 risk(sample.size, mu, d.BIC))

matplot(mu, risk.mu, ylab = 'Risk', xlab = expression(mu), type = 'l', lwd = 2, col = c("red", "blue"))
legend('bottomright', legend = c('AIC', 'BIC'), lty = c(1,2), col = c('red', 'blue'), lwd = c(2,2))

