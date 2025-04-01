#변수객체 삭제
rm(list = ls())
#중회귀모형
market2 = read.csv("c:/data/reg/market-2.csv")
head(market2,3)
#2번째 열과 3번째 열을 추출
X = market2[,c(2:3)]
X = cbind(1, X)
Y = market2[,4]
X = as.matrix(X)
Y = as.matrix(Y)
XTX = t(X) %*% X
XTX

XTXI = solve(XTX)
XTY = t(X) %*% Y
beta = XTXI %*% XTY
# beta행렬을 소수점 셋째 자리까지 반올림
beta = round(beta,3)
beta

#분산분석표
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

#추가제곱합
health = read.csv("c:/data/reg/health.csv")
head(health,3)

#모형적합
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

#실제 분석 사례
chemical = read.csv("c:/data/reg/chemical.csv")
head(chemical)
#1번째 열 제외하고 데이터를 가져옴
summary(chemical[,-1]) 

#첫 번째 열을 제외한 나머지 변수들 간의 상관계수 
#+1 : 완벽한 양의 상관관계, 0:상관관계 없음, -1: 완력한 음의상관관계
cor(chemical[,-1])
chemical_lm = lm(loss ~ speed + temp,  data=chemical)
summary(chemical_lm)

library(car)
#특정 독립변수와 종속변수 사이의 순수한 관계
#speed | others : loss에 순수하게 영향을 끼치는 speed
avPlots(chemical_lm)

anova(chemical_lm)
#speed의 p-value 계산
pf(45.02, df1 = 1, df2 = 9, lower.tail = FALSE)
#temp의 p-value 계산
pf(7.5867, df1 = 1, df2 = 9, lower.tail = FALSE)

#독립변수인 speed와 잔차(residuals)의 관계를 시각화
plot(chemical$speed, chemical_lm$resid)
#그래프 상의 특정 점을 "마우스로 클릭해서 식별"
identify(chemical$speed, chemical_lm$resid)
plot(chemical$temp, chemical_lm$resid)
identify(chemical$temp, chemical_lm$resid)

plot(chemical_lm$fitted, chemical_lm$resid)
# 그래프에 수평선 하나 추가하는 명령어
# h = 0	Y축의 값이 0인 위치에 수평선을 그림
abline(h=0, lty=2)
identify(chemical_lm$fitted, chemical_lm$resid)
