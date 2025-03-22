#중회귀모형
market2 = read.csv("c:/data/reg/market-2.csv")
head(market2,3)
X = market2[,c(2:3)]
X = cbind(1, X)
Y = market2[,4]
X = as.matrix(X)
Y = as.matrix(Y)
XTX = t(X) %*% X
XTX
XTY
XTXI = solve(XTX)
XTY = t(X) %*% Y
beta = XTXI %*% XTY
beta = round(beta,3)
beta

market2_lm = lm(Y ~ X1+X2, data=market2)
summary(market2_lm)
anova(market2_lm)
summary(market2_lm)

install.packages("lm.beta")
library(lm.beta)
market2_lm = lm(Y ~ X1+X2, data=market2)
market2_beta = lm.beta(market2_lm)
print(market2_beta)
coef(market2_beta)
summary(market2_beta)

pred_x = data.frame(X1=10, X2=10)
pc = predict(market2_lm, int="c", newdata=pred_x)
pc

pc99 = predict(market2_lm, int="c", level=0.99, newdata=pred_x)
pc99

summary(market2_lm)

health = read.csv("c:/data/reg/health.csv")
head(health,3)

h1_lm = lm(Y ~ X1, data=health)
h2_lm = lm(Y ~ X1+X4, data=health)
h3_lm = lm(Y ~ X1+X3+X4, data=health)
h4_lm = lm(Y ~ X1+X2+X3+X4, data=health)

anova(h1_lm, h2_lm)

anova(h2_lm, h3_lm)
anova(h3_lm, h4_lm)

install.packages("car")
library(car)
h4_lm = lm(Y ~ X1+X2+X3+X4, data=health)
avPlots(h4_lm)

summary(h4_lm)

chemical = read.csv("c:/data/reg/chemical.csv")
head(chemical)

summary(chemical[,-1])
cor(chemical[,-1])
chemical_lm = lm(loss ~ speed + temp,  data=chemical)
summary(chemical_lm)

library(car)
avPlots(chemical_lm)

anova(chemical_lm)

plot(chemical$speed, chemical_lm$resid)
identify(chemical$speed, chemical_lm$resid)
plot(chemical$temp, chemical_lm$resid)
identify(chemical$temp, chemical_lm$resid)

plot(chemical_lm$fitted, chemical_lm$resid)
abline(h=0, lty=2)
identify(chemical_lm$fitted, chemical_lm$resid)