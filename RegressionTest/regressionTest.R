#Regression Test
rm(list=ls())

#끓는물의 온도와 대기압력에 대한 데이터(James D. Forbes)
forbes = read.csv("c:/data/reg/forbes.csv")
forbes$Lpress = 100*log10(forbes$press)
head(forbes)

plot(forbes$temp, forbes$Lpress, pch=19)
identify(forbes$temp, forbes$Lpress)

forbes_lm = lm(Lpress ~ temp, data=forbes)
summary(forbes_lm)

anova(forbes_lm)

#is.diag : 회귀 진단 값들을 한꺼번에 계산해주는 함수
#is.diag는 회귀진단값들의 리스트 객체를 리턴함
forbes_res = ls.diag(forbes_lm)
#어떤 회귀 진단값(회귀진단정보)들이 들어있는지 확인할 시 names사용 
names(forbes_res)

resid_result = cbind(forbes_res$std.res, forbes_res$stud.res, forbes_res$hat)
colnames(resid_result) = c("standardized resid", "studentized resid", "Hat")
resid_result = round(resid_result, 3)
print(resid_result)

#car의 outlierTest()를 이용한 방법
rstudent(forbes_lm)

install.packages("car")
library(car)
outlierTest(forbes_lm)

#Prater의 가솔린자료
prater = read.csv('c:/data/reg/prater.csv')
head(prater)

prater_lm = lm(Y ~ X1+X2+X3+X4, data=prater)
summary(prater_lm)

#유의하지 않은 설명변수 제거
start_lm = lm( Y ~ 1, data=prater )
full_lm = lm(Y ~ X1+X2+X3+X4, data=prater)
step(start_lm, scope=list(upper=full_lm), data=prater, direction="both")






