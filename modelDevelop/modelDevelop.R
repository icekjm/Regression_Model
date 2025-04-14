rm(list=ls())

#1966년부터 1990년까지의 우리나라 인구 10만명당 교통범죄 발생수와 자동차 보급대수
tcrime = read.csv("c:\\data\\reg\\tcrime.csv")
head(tcrime)
plot(tcrime$motor, tcrime$tcratio, xlab="motor", ylab="tcime", pch=19)

tcrime_lm = lm(tcratio ~ motor + I(motor^2), data=tcrime)
summary(tcrime_lm)

#비누 생산공정에서의 비누 부스러기 부산물의 양과 공정속도
soup = read.csv("c:\\data\\reg\\soup.csv")
soup[c(1, 15, 16, 27),]
#아래factor에서 원래값 0,1은 남아있으며 label로 대체되는것 뿐임
#이 원래값은 아래 모형을 적합시(lm부분) D에 각각 0, 1로 들어감
soup$D = factor(soup$D, levels=c(0,1), label=c("Line0", "Line1"))
soup[c(1, 15, 16, 27),]

plot(soup$X, soup$Y, type="n")
points(soup$X[soup$D=="Line1"], soup$Y[soup$D=="Line1"], pch=17, col="BLUE")
points(soup$X[soup$D=="Line0"], soup$Y[soup$D=="Line0"], pch=19, col="RED")
#levels의 순서는 위에서 factor의 levels=c(0,1)과 관련
legend("bottomright", legend=levels(soup$D), pch=c(19,17), col=c("RED", "BLUE"))

soup_lm = lm(Y~X+D, data=soup)
#D가 "Line1"일 경우, Y는 "Line0"보다 53.13만큼 더 큼
summary(soup_lm)

#산점도에 적합된 회귀직선
abline(27.28179, 1.23074, lty=2, col="RED")
abline(27.28179+53.1292, 1.23074, lty=2, col="BLUE")

#교호작용 효과가 있나 실제로 검증
soup2_lm = lm(Y ~ X+D+X:D, data=soup)
summary(soup2_lm)






