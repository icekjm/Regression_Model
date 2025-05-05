rm(list = ls())

#흰 기러기 자료
goose = read.csv("c:/data/reg/goose.csv")
head(goose)

goose_lm = lm(photo ~ obsA, data=goose)
plot(goose_lm$fitted, goose_lm$resid, pch=19)

#Goldfeld-Quandt test
install.packages("lmtest")
library(lmtest)
#order.by 정렬기준, fraction-20 중심부에 위치한 데이터 20% 버리기
gqtest(goose_lm, order.by = ~obsA, data=goose, fraction=20)

#Breusch-Pagan(BP test)
install.packages("car")
library(car)
ncvTest(goose_lm)

#회귀모형의 선형성
tree = read.csv("c:/data/reg/tree.csv")
head(tree, 3)

tree_lm = lm(V ~ D+H, data=tree)
names(tree_lm)
plot(tree$D, tree_lm$residuals, pch=19)
plot(tree$H, tree_lm$residuals, pch=19)

#오차의 정규성
library(ggplot2)
install.packages("qqplotr")
library(qqplotr)
goose = read.csv("c:/data/reg/goose.csv")
goose_lm = lm(photo ~ obsA, data=goose)
#표준화된 잔차를 계산
rstandard_values = rstandard(goose_lm)
ggplot(mapping = aes(sample = rstandard_values)) +
    stat_qq_point(size = 2, color = "red") +
    stat_qq_line(color="black") +
    xlab("theoretical") + ylab("rstandard")

#반응변수의 변환: Box-Cox 변환
energy = read.csv("c:/data/reg/energy.csv")
head(energy, 3)
energy_lm = lm(Y ~ X, data=energy)
plot(energy_lm$fitted.values, energy_lm$residuals, pch=19)

library(MASS)
energy_lm = lm(Y ~ X, data=energy)
bc = boxcox(energy_lm)
str(bc)
bc_lambda = bc$x[which.max(bc$y)]


