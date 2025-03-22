rm(list = ls())  # 모든 객체 삭제
gc()             # 메모리 정리

super = read.csv("c:/data/reg/supermarket.csv")
head(super, 3)
plot(super$price, super$time, pch=19)

#회귀모형을 적합할때 lm을 사용
#lm안에서 종속변수, 독립변수, 데이타 순으로 오게됨
super_lm = lm(time ~ price, data=super)
summary(super_lm)

anova(super_lm)
names(super_lm)
cbind(super, super_lm$residuals, super_lm$fitted.values)
cbind(super, super_lm$resid, super_lm$fitted)

plot(super$price, super_lm$resid, pch=19)
abline(h=0, lty=2)

super_predict = predict(super_lm, interval="predict")
super_data = cbind(super, super_predict)

library(ggplot2)

ggplot(super_data, aes(x=price, y=time)) +
  geom_point() +
  stat_smooth() +
  geom_line(aes(y=lwr), col = "coral2", linetype="dashed") +
  geom_line(aes(y=upr), col = "coral2", linetype="dashed")
  
  
  
