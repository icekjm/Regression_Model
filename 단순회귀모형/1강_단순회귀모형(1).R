market = read.csv("c:/data/reg/market-1.csv")
head(market)
head(market, 3)
plot(market$X, market$Y, xlab="인테리어비", ylab="총판매액", pch=19)
title("인테리어비와 판매액의 산점도")

#아래 의미는?
market_lm = lm(Y ~ X, data=market)

summary(market_lm)
abline(market_lm)
#아래 의미는?
identify(market$X, market$Y, tolerance = 1)
names(market_lm)

xbar = mean(market$X)
ybar = mean(market$Y)

points(xbar, ybar, pch=17, cex=2.0, col="RED")
text(xbar, ybar, "(8.85, 19.36)")
fx = "Y-hat = 0.328 + 2.14*X"
text(locator(1), fx)

#아래 분산분석표를 출력해서보면 MSE와 관련된 항목이 2.52라는것을 알수 있고 여기
#에 루트를 씌우면 위 summary를 해서 나온 Residual standard error가 1.587이라는것
#을 알 수 있음
anova(market_lm)

