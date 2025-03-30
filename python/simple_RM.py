import numpy as np
import pandas as pd
import statsmodels.formula.api as smf
import statsmodels.api as sm
from statsmodels.formula.api import ols
from sklearn.linear_model import LinearRegression
import matplotlib.pyplot as plt
import seaborn as sns

#1.simple_linear_regressionModel

market = pd.read_csv("c:/data/reg/market-1.csv")
# print(market)
# print(market.head())
#시각화 스타일 제공 sns
# sns.scatterplot(x='X', y='Y', data=market)
#plt.title('Scatter Plot')
# 플롯을 화면에 표시, 그래프를 실제로 띄우는 일은 matplotlib를 이용함
#plt.show()

# Method 1 : Using ols formula

# ols(선형 회귀 모델을 설정하는 함수), fit은 실제 데이터에 적합
# market_lm = ols('Y~X', data=market).fit()
#데이터에 따른 회귀모형 적합결과
#print(market_lm.summary())

#scatterplot with regression line
# regplot(산점도 + 회귀선을 함께 그리는 Seaborn의 함수)
# sns.regplot(x='X', y='Y', data=market, ci=None)
# plt.title('Scatter Plot with Reg. line')
# plt.show()

#분산분석표
#print(sm.stats.anova_lm(market_lm))
#잔차(residuals) 중 앞의 5개를 출력,잔차=실제 Y값−예측된 Y값
# print(market_lm.resid.head())

#회귀 모델에서 예측된 Y 값 5개 출력
# print(market_lm.fittedvalues.head())

#잔차산점도 (fitted values, resid)
#회귀 분석 후 잔차 분석을 시각화
# plt.scatter(market_lm.fittedvalues, market_lm.resid)
# plt.xlabel("fitted")
# plt.ylabel("residuals")
# plt.axhline(y=0, linestyle='--')
#아래 명령어를 통해 해당 그래프를 볼 수 있음
#점들이 0 기준선 위아래로 랜덤하게 흩어져 있음 → 좋은 모델!
# plt.show()
#create scatterplot with regression line and confidence interval lines
#X와 Y 간의 산점도 + 회귀선(line) + 신뢰구간(CI) 시각화
# sns.regplot(x='X', y='Y', data=market)
# plt.title('Reg. line with CI')
#아래 그래프에서, 연한 파란색 음영 영역 → 95% 신뢰구간 -> 모집단 종속변수의 평균값이 구간 안에 95% 확률로 들어감
# plt.show()

# Method 2 : Using sm.OLS
#회귀분석에 필요한 상수항 추가
X = sm.add_constant(market.X)
Y = market.Y
market_lm = sm.OLS(Y,X).fit()
print(market_lm.summary())