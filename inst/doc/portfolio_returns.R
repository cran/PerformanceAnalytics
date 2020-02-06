### R code from vignette source 'portfolio_returns.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: portfolio_returns.Rnw:60-64
###################################################
prices = cbind(c(5, 7, 6, 7),
                c(10, 11, 12, 8))
dimnames(prices) = list(paste0("t",0:3), c("A", "B"))
prices


###################################################
### code chunk number 2: portfolio_returns.Rnw:91-96
###################################################
V_P0 = 1000
N = ncol(prices)
w = rep(1 / N, N)
lambda = w * V_P0 / prices["t0",]
lambda


###################################################
### code chunk number 3: portfolio_returns.Rnw:101-107
###################################################
# Compute the value of the assets
V_assets <- matrix(0, nrow(prices), ncol(prices), dimnames=dimnames(prices))
for(i in 1:nrow(prices)){
  V_assets[i,] = prices[i,] * lambda
}
V_assets


###################################################
### code chunk number 4: portfolio_returns.Rnw:110-113
###################################################
# Compute the value of the portfolio
V_P = rowSums(V_assets)
V_P


###################################################
### code chunk number 5: portfolio_returns.Rnw:118-121
###################################################
# Compute the portfolio returns
R_t = diff(V_P) / V_P[1:3]
R_t


###################################################
### code chunk number 6: portfolio_returns.Rnw:126-128
###################################################
weights = V_assets / V_P
weights


###################################################
### code chunk number 7: portfolio_returns.Rnw:136-141
###################################################
library(PerformanceAnalytics)
data(edhec)
R = edhec["1997", 1:5]
colnames(R) = c("CA", "CTAG", "DS", "EM", "EMN")
R


###################################################
### code chunk number 8: portfolio_returns.Rnw:152-156
###################################################
N = ncol(R)
weights = xts(matrix(rep(1 / N, N), 1), as.Date("1996-12-31"))
colnames(weights) = colnames(R)
weights


###################################################
### code chunk number 9: portfolio_returns.Rnw:184-186
###################################################
V_0 = 1
bop_value = eop_value = matrix(0, 2, ncol(R))


###################################################
### code chunk number 10: portfolio_returns.Rnw:190-193
###################################################
t = 1
bop_value[t,] = coredata(weights) * V_0
eop_value[t,] = coredata(1 + R[t,]) * bop_value[t,]


###################################################
### code chunk number 11: portfolio_returns.Rnw:197-200
###################################################
t = 2
bop_value[t,] = eop_value[t-1,]
eop_value[t,] = coredata(1 + R[t,]) * bop_value[t,]


###################################################
### code chunk number 12: portfolio_returns.Rnw:211-218
###################################################
bop_weights = eop_weights = matrix(0, 2, ncol(R))
for(t in 1:2){
  bop_weights[t,] = bop_value[t,] / sum(bop_value[t,])
  eop_weights[t,] = eop_value[t,] / sum(eop_value[t,])
}
bop_weights
eop_weights


###################################################
### code chunk number 13: portfolio_returns.Rnw:226-229
###################################################
V = c(V_0, rowSums(eop_value))
R_P = diff(V) / V[1:2]
R_P


###################################################
### code chunk number 14: portfolio_returns.Rnw:237-242
###################################################
contribution = matrix(0, 2, ncol(R))
for(t in 1:2){
  contribution[t,] = (eop_value[t,] - bop_value[t,]) / sum(bop_value[t,])
}
contribution


###################################################
### code chunk number 15: portfolio_returns.Rnw:252-253
###################################################
args(Return.portfolio)


###################################################
### code chunk number 16: portfolio_returns.Rnw:258-268
###################################################
# Equally weighted, buy and hold portfolio returns
Return.portfolio(R)

# Equally weighted, rebalanced quarterly portfolio returns
Return.portfolio(R, rebalance_on="quarters")

# Equally weighted, rebalanced quarterly portfolio returns. 
# Use verbose=TRUE to return additional information 
# including asset values and weights
Return.portfolio(R, rebalance_on="quarters", verbose=TRUE)


