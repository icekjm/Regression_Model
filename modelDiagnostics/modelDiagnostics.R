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
