import numpy as np
import pandas as pd
import statsmodels.formula.api as smf
import statsmodels.api as sm #분산분석표 이용 및 데이터를 회귀선에 적합시
from statsmodels.formula.api import ols #데이터를 회귀선에 적합할 시
from sklearn.linear_model import LinearRegression
import matplotlib.pyplot as plt
import seaborn as sns

#2.multiple_linear_regressionModel
market2 = pd.read_csv("c:/data/reg/market-2.csv")
# print(market2.head())

# Method 1 : using ols
#데이터를 적합시킨 결과
# market2_lm = ols('Y~X1+X2', data=market2).fit()
# print(market2_lm.summary())
#분산분석표 출력
# sm.stats.anova_lm(market2_lm)
# print(sm.stats.anova_lm(market2_lm))
# print(np.round(market2_lm.rsquared, 4))
# beta coefficients
#z-score 정규화를 이용한 분석
from scipy import stats
#수치형 데이터를 가져오되 결측값은 제외하고 z-score정규화를 수행함
# market2_z = market2.select_dtypes(include=[np.number]).dropna().apply(stats.zscore)
# 정규화된 데이터를 다중 선형 회귀모델에 적합
# market2_z_reg = ols('Y~X1+X2', data=market2_z).fit()
#z-score정규화?각 독립변수의 단위가 다르기때문에 이를 보정하는 작업임 ->각 회귀계수 크기 비교가 가능해짐
# print(market2_z_reg.summary())

# Method 2 : Using sm.OLS
# X = market2[['X1', 'X2']]
# X = sm.add_constant(X)
# Y = market2.Y
# market2_lm = sm.OLS(Y, X).fit()
# print(market2_lm.summary())

# Metohd 3 :　Using LinearRegression()
# 아래는 scikit-learn을 이용한 방식
X = market2[['X1', 'X2']]
Y = market2['Y']
market3_lm = LinearRegression().fit(X,Y)
#학습된 회귀계수출력
# print(market3_lm.intercept_, market3_lm.coef_)
#dir(market3_lm)
#예측값 출력
print(market3_lm.predict(X))