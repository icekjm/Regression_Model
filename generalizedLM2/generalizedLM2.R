rm(list = ls())

#8.1.1 승산비와 상대위험도 그리고 사례-대조 연구
data(esoph)
head(esoph, 3)
attach(esoph)

names(esoph)
##반응변수 설정
y = cbind(ncases, ncontrols)
##설명변수 범주 이름 재설정
# 어떤 범주들이 들어있는지 확인
levels(agegp)
# 원래 순서형이었던 연령대를, 순서 없는 명목형 변수로 강제 변환
n.agegp = factor(agegp, ordered = FALSE)
levels(n.agegp) = c("25-34", "35-44", "45-54", "55-64", "65-74", "75+")
#음주량
levels(alcgp)
n.alcgp = factor(alcgp, ordered=FALSE)
levels(n.alcgp) = c("0-39", "40-79", "80-119", "120+")
#흡연량
levels(tobgp)
n.tobgp = factor(tobgp, ordered = FALSE)
levels(tobgp) = c("0-9", "10-19", "20-29", "30+")

##로지스틱 회귀모형 적합하기
logit_main = glm(y~n.agegp+n.alcgp+n.tobgp, family=binomial(link=logit))
summary(logit_main)

logit_main0 = glm(y~1, family=binomial(link=logit))
anova(logit_main0, logit_main, test="LRT")

#잔차분석
par(mfrow=c(2,2))
plot(logit_main)

#회귀계수 추정값의 해석
exp(coef(logit_main))
#95%신뢰구간
exp(confint(logit_main, parm="n.alcgp40-79", level=0.95))

## 설명변수 범주 통합과 모형의 간결성
# 나이의 세 범주 통합
n4.agegp = n.agegp
levels(n4.agegp)[4:6] = "54+" 
levels(n4.agegp)
#흡연량의 두 범주 통합
n3.tobgp = n.tobgp
levels(n3.tobgp)[2:3] = "10-29"
levels(n3.tobgp)
##통합 범주 사용 모형 적합
logit_main.r = glm(y ~ n4.agegp+n.alcgp+n3.tobgp, family=binomial(link = logit))
summary(logit_main.r)

#모형(8.10) vs 모형(8.8)의 모형선택에 대한 가능도비 검정
anova(logit_main.r, logit_main, test="LRT")






