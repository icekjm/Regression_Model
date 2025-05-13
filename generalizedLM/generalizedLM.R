rm(list=ls())

#로지스틱스 회귀모형
glider = read.csv("c:/data/reg/sugar_glider_binomial.csv")
head(glider, 3)
logit_m1 = glm(occurr~p_size_km+con_metric, family=binomial(link=logit), data=glider)
summary(logit_m1)

logit_m0 = glm(occurr~1, family = binomial(link=logit), data=glider)
anova(logit_m0, logit_m1, test='Chisq')

logit_m2 = glm(occurr ~ p_size_km, family=binomial(link=logit), data=glider)
summary(logit_m2)
anova(logit_m2, logit_m1, test='Chisq')
AIC(logit_m2, logit_m1)

#로지스틱 회귀모형의 해석
glider_g = read.csv("c:/data/reg/sugar_glider_binomial_g.csv")
head(glider_g, 3)
y = cbind(glider_g$cases, glider_g$count-glider_g$cases)
logit_mg = glm(y~glider_g$p_size_med, family = binomial(link=logit))
summary(logit_mg)

#로지스틱 함수의 선형근사적 해석
install.packages("mfx")
library(mfx)
logitmfx(logit_m2, data=glider, atmean = F)

logit_m2 = glm(occurr ~ p_size_km, family=binomial(link=logit), data=glider)
exp(coef(logit_m2))
exp(confint(logit_m2, parm="p_size_km", level=0.95))
exp(0.022)

#x=150에서 Sugar Glider가 출현할 확률
x = 150
predict(logit_m2, list(p_size_km = x), type = "response")
vcov(logit_m2)


#로지스틱 회귀모형 적합도의 시각적 검토


#프로빗모형
glider = read.csv("c:/data/reg/sugar_glider_binomial.csv")
attach(glider)
probit_m = glm(occurr~p_size_km, family=binomial(link=probit))
summary(probit_m)

##프로빗 모형에서 x=150km에서 확률추정과 확률의 신뢰구간 추정
#한 개의 값만 예측할 때는 이렇게 list(변수명 = 값) 형태, 여러값일때는 data.frame
h.pi.pb = predict(probit_m, list(p_size_km=150), type="link", se.fit=T)
names(h.pi.pb)
#표준정규분포의 누적분포함수(CDF)를 통해 Z값을 확률값으로 변환
pnorm(h.pi.pb$fit)
#probit 값의 95% 신뢰구간의 하한과 상한

#qnorm(0.975) 표준 정규분포에서 상위 2.5% 지점의 Z값
l.b = h.pi.pb$fit-qnorm(0.975)*h.pi.pb$se.fit
u.b = h.pi.pb$fit+qnorm(0.975)*h.pi.pb$se.fit
#확률의 95% 신뢰구간 추정
pnorm(l.b); pnorm(u.b)

###로지스틱 회귀모형과 프로빗모형 적합결과 그림으로 비교하기
#원자료 jitter 형식으로 그리기
plot(p_size_km, occurr, type="n", xlab = '구획의 크기(x)',
     ylab=expression(hat(pi)(x):"occur.")
     )
#rug(...) 그래프의 축에 작게 발표시를 그려줌
#jitter(...) 값이 똑같은 경우 겹쳐서 보이기 때문에 약간 흔들어 분산시켜줌
#side = 3 x축의 윗부분을 의미
rug(jitter(p_size_km[occurr==0]))
rug(jitter(p_size_km[occurr==1]), side=3)

#확률추정곡선그리기
#lty는 선의종류
#lwd는 선의 두께
x = seq(23,226,1)
hat.pi.p = predict(probit_m, list(p_size_km=x), type="response")
lines(x, hat.pi.p, col='blue', lty=1, lwd=1.5)

hat.pi.l = predict(logit_m2, list(p_size_km=x), type="response")
lines(x, hat.pi.l, col='red', lty=2, lwd=1.5)

#표본비율그리기
cl.intr = cut(p_size_km, 5)
s.prop = tapply(occurr, cl.intr, mean); s.prop = as.vector(s.prop)
md.size = tapply(p_size_km, cl.intr, median); md.size = as.vector(md.size)
#type: 점만 그림, pch: 점의 모양, cex:점크기 확대, col: 점색깔 파란색
lines(md.size, s.prop, type="p", pch=20, cex=1.5, col="blue")
legend(locator(1), c("프로빗모형","로지스틱회귀모형"), lty=c(1,2), 
       col=c("blue", "red"), cex=0.7)




