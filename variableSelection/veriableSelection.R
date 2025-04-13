rm(list=ls())
#3.5 변수선택의 방법
#3.5.1 모든 가능한 회귀
hald = read.csv("c:/data/reg/hald.csv")
head(hald)

#어떤 독립변수 조합이 가장 좋은 모델인지 선택
install.packages("leaps")
library(leaps)
all_lm = regsubsets(Y ~ . , data=hald)
(rs=summary(all_lm))

#regsubsets() 함수의 결과 객체(rs)에 담긴 정보 확인
names(rs)

round(rs$rsq, 3)
round(rs$adjr2, 3)
round(rs$cp, 3)

X = hald[, -5]
Y = hald[,5]
leaps(X, Y, method='Cp')

install.packages("olsrr")
library(olsrr)
model = lm(Y~ X1+X2+X3+X4, data=hald)
ols_step_all_possible(model)


#Forward Selection
start_lm = lm(Y~1, data=hald)
full_lm = lm(Y~ ., data=hald)
step(start_lm, scope = list(lower=start_lm, upper=full_lm), direction="forward")

library(olsrr)
model = lm(Y ~ X1+X2+X3+X4, data=hald)
ols_step_forward_p(model)
#Backward Elimination
step(full_lm, data=hald, direction="backward")
ols_step_backward_p(model)
#Stepwise Selection
step(start_lm, scope = list(upper=full_lm), data=hald, direction="both")
ols_step_both_p(model)




