### R code from vignette source 'EstimationComoments.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: LoadData
###################################################
library(PerformanceAnalytics)
data(edhec)
colnames(edhec)
head(edhec[, 1:6], n = 5)


###################################################
### code chunk number 2: Plugin
###################################################
m3 <- M3.MM(edhec)
m4 <- M4.MM(edhec)
dim(m3)
dim(m4)


###################################################
### code chunk number 3: PluginPort
###################################################
p <- ncol(edhec)
w <- rep(1 / p, p)
m3port <- t(w) %*% m3 %*% (w %x% w)
m4port <- t(w) %*% m4 %*% (w %x% w %x% w)


###################################################
### code chunk number 4: PluginPortHidden
###################################################
m3port_2 <- PerformanceAnalytics:::portm3(w, M3.MM(edhec))
m3port_3 <- PerformanceAnalytics:::portm3(w, M3.MM(edhec, as.mat = F))
c(m3port, m3port_2, m3port_3)


###################################################
### code chunk number 5: PluginPort2
###################################################
portreturns <- edhec %*% w
m3port_univ <- mean((portreturns - mean(portreturns))^3)
m4port_univ <- mean((portreturns - mean(portreturns))^4)
c(m3port, m3port_univ, m4port, m4port_univ)


###################################################
### code chunk number 6: PluginPortsumm
###################################################
summ_moms <- matrix(NA, nrow = 17, ncol = 2)
summ_moms[1,] <- c(m3port_univ, m4port_univ)


###################################################
### code chunk number 7: PluginUnb
###################################################
m3 <- M3.MM(edhec, unbiased = TRUE)

set.seed(201706)
x <- matrix(rexp(10000000), nrow = 50)
xc <- x - matrix(colMeans(x), nrow = 50, ncol = 200000, byrow = TRUE)
skews_plugin <- colMeans(xc^3)
mean(skews_plugin)
mean(skews_plugin) * 50^2 / (49 * 48)


###################################################
### code chunk number 8: StructIndep
###################################################
m3 <- M3.struct(edhec, "Indep")
m4 <- M4.struct(edhec, "Indep")
m3port <- PerformanceAnalytics:::portm3(w, m3)
m4port <- PerformanceAnalytics:::portm4(w, m4)
c(m3port_univ, m3port, m4port_univ, m4port)


###################################################
### code chunk number 9: StructIndepsumm
###################################################
summ_moms[2,] <- c(m3port, m4port)


###################################################
### code chunk number 10: StructIndepInd
###################################################
m3 <- M3.struct(edhec, "IndepId")
m4 <- M4.struct(edhec, "IndepId")


###################################################
### code chunk number 11: StructIndepIndsumm
###################################################
m3port <- PerformanceAnalytics:::portm3(w, m3)
m4port <- PerformanceAnalytics:::portm4(w, m4)
summ_moms[3,] <- c(m3port, m4port)


###################################################
### code chunk number 12: Struct1f
###################################################
f <- rowMeans(edhec)
m3 <- M3.struct(edhec, "observedfactor", f)
m4 <- M4.struct(edhec, "observedfactor", f)


###################################################
### code chunk number 13: Struct1fsumm
###################################################
m3port <- PerformanceAnalytics:::portm3(w, m3)
m4port <- PerformanceAnalytics:::portm4(w, m4)
summ_moms[4,] <- c(m3port, m4port)


###################################################
### code chunk number 14: structCC
###################################################
m3 <- M3.struct(edhec, "CC")
m4 <- M4.struct(edhec, "CC")


###################################################
### code chunk number 15: structCCsumm
###################################################
m3port <- PerformanceAnalytics:::portm3(w, m3)
m4port <- PerformanceAnalytics:::portm4(w, m4)
summ_moms[5,] <- c(m3port, m4port)


###################################################
### code chunk number 16: structSim
###################################################
m3 <- M3.struct(edhec, "latent1factor")


###################################################
### code chunk number 17: structSimsumm
###################################################
m3port <- PerformanceAnalytics:::portm3(w, m3)
summ_moms[6,] <- c(m3port, NA)


###################################################
### code chunk number 18: structSim
###################################################
m3 <- M3.struct(edhec, "CS")


###################################################
### code chunk number 19: ShrinkIndep
###################################################
# target "Indep"
m3 <- M3.shrink(edhec, 1)$M3sh
m4 <- M4.shrink(edhec, 1)$M4sh

# target "IndepId"
m3 <- M3.shrink(edhec, 2)$M3sh
m4 <- M4.shrink(edhec, 2)$M4sh

# target "1-factor"
m3 <- M3.shrink(edhec, 3, f)$M3sh
m4 <- M4.shrink(edhec, 3, f)$M4sh

# target "constant correlation"
m3 <- M3.shrink(edhec, 4)$M3sh
m4 <- M4.shrink(edhec, 4)$M4sh

# target "latent 1-factor model of Simaan (1993)"
m3 <- M3.shrink(edhec, 5)$M3sh

# target "central-symmetry"
m3 <- M3.shrink(edhec, 6)$M3sh


###################################################
### code chunk number 20: ShrinkIndepsumm
###################################################
m3 <- M3.shrink(edhec, 1)$M3sh
m4 <- M4.shrink(edhec, 1)$M4sh
m3port <- PerformanceAnalytics:::portm3(w, m3)
m4port <- PerformanceAnalytics:::portm4(w, m4)
summ_moms[7,] <- c(m3port, m4port)
m3 <- M3.shrink(edhec, 2)$M3sh
m4 <- M4.shrink(edhec, 2)$M4sh
m3port <- PerformanceAnalytics:::portm3(w, m3)
m4port <- PerformanceAnalytics:::portm4(w, m4)
summ_moms[8,] <- c(m3port, m4port)
m3 <- M3.shrink(edhec, 3, f)$M3sh
m4 <- M4.shrink(edhec, 3, f)$M4sh
m3port <- PerformanceAnalytics:::portm3(w, m3)
m4port <- PerformanceAnalytics:::portm4(w, m4)
summ_moms[9,] <- c(m3port, m4port)
m3 <- M3.shrink(edhec, 4, f)$M3sh
m4 <- M4.shrink(edhec, 4, f)$M4sh
m3port <- PerformanceAnalytics:::portm3(w, m3)
m4port <- PerformanceAnalytics:::portm4(w, m4)
summ_moms[10,] <- c(m3port, m4port)
m3 <- M3.shrink(edhec, 5)$M3sh
m3port <- PerformanceAnalytics:::portm3(w, m3)
summ_moms[11,] <- c(m3port, NA)
m3 <- M3.shrink(edhec, 6)$M3sh
m3port <- PerformanceAnalytics:::portm3(w, m3)
summ_moms[12,] <- c(m3port, NA)


###################################################
### code chunk number 21: ShrinkMTb
###################################################
m3 <- M3.shrink(edhec, c(1, 3, 4), f)$M3sh
m4 <- M4.shrink(edhec, c(1, 3, 4), f)$M4sh


###################################################
### code chunk number 22: ShrinkMTbsumm
###################################################
m3port <- PerformanceAnalytics:::portm3(w, m3)
m4port <- PerformanceAnalytics:::portm4(w, m4)
summ_moms[13,] <- c(m3port, m4port)


###################################################
### code chunk number 23: ShrinkMTunb
###################################################
m3 <- M3.shrink(edhec, c(1, 2, 6), unbiasedMSE = T)$M3sh


###################################################
### code chunk number 24: ShrinkMTunbsumm
###################################################
m3port <- PerformanceAnalytics:::portm3(w, m3)
summ_moms[14,] <- c(m3port, NA)


###################################################
### code chunk number 25: EMWA
###################################################
m3 <- M3.ewma(edhec, lambda = 0.97)
m4 <- M4.ewma(edhec, lambda = 0.97)


###################################################
### code chunk number 26: EWMAsumm
###################################################
m3port <- PerformanceAnalytics:::portm3(w, m3)
m4port <- PerformanceAnalytics:::portm4(w, m4)
summ_moms[15,] <- c(m3port, m4port)
# summary_momentestimates <- summ_moms
# colnames(summary_momentestimates) <- c("m3 (1e-07)", "m4 (1e-07)")
# rownames(summary_momentestimates) <- c("sample", "struct - Indep", "struct - IndepInd", "struct - 1f", "struct - CC",
#                                        "struct - Simaan", "shrink - Indep", "shrink - IndepInd", "shrink - 1f",
#                                        "shrink - CC", "shrink - Simaan", "shrink - CS", "shrink - Indep/1f/CC", 
#                                        "shrink - Indep/IndepId/CS", "EWMA")
# summary_momentestimates <- 1e07 * summary_momentestimates


###################################################
### code chunk number 27: MCA
###################################################
m3 <- M3.MCA(edhec, k = 3)$M3mca
m4 <- M4.MCA(edhec, k = 3)$M4mca


###################################################
### code chunk number 28: MCAsumm
###################################################
m3port <- PerformanceAnalytics:::portm3(w, m3)
m4port <- PerformanceAnalytics:::portm4(w, m4)
summ_moms[17,] <- c(m3port, m4port)
m3port <- PerformanceAnalytics:::portm3(w, M3.MCA(edhec, k = 1, as.mat = FALSE)$M3mca)
m4port <- PerformanceAnalytics:::portm4(w, M4.MCA(edhec, k = 1, as.mat = FALSE)$M4mca)
summ_moms[16,] <- c(m3port, m4port)
summary_momentestimates <- summ_moms
colnames(summary_momentestimates) <- c("m3 (1e-07)", "m4 (1e-07)")
rownames(summary_momentestimates) <- c("sample", "struct - Indep", "struct - IndepInd", "struct - 1f", "struct - CC",
                                       "struct - Simaan", "shrink - Indep", "shrink - IndepInd", "shrink - 1f",
                                       "shrink - CC", "shrink - Simaan", "shrink - CS", "shrink - Indep/1f/CC", 
                                       "shrink - Indep/IndepId/CS", "EWMA", "MCA - 1 factor", "MCA - 3 factors")
summary_momentestimates <- 1e07 * summary_momentestimates


###################################################
### code chunk number 29: giveSummary
###################################################
summary_momentestimates


###################################################
### code chunk number 30: VaRsample
###################################################
w <- rep(1 / ncol(edhec), ncol(edhec))
p <- 0.95
m <- colMeans(edhec)
sigma <- cov(edhec)
m3 <- M3.MM(edhec)
m4 <- M4.MM(edhec)
VaR95 <- VaR(p = p, method = "modified", portfolio_method = "component", 
             weights = w, mu = m, sigma = sigma, m3 = m3, m4 = m4)
VaR95


###################################################
### code chunk number 31: VaRsample
###################################################
ES95 <- ES(p = p, method = "modified", portfolio_method = "component", 
           weights = w, mu = m, sigma = sigma, m3 = m3, m4 = m4)
ES95


###################################################
### code chunk number 32: VaRestimates
###################################################
rm95 <- matrix(NA, nrow = 13, ncol = 2)
VaRcomp <- matrix(NA, nrow = 13, ncol = 13)
EScomp <- matrix(NA, nrow = 13, ncol = 13)

temp <- VaR(p = p, method = "modified", portfolio_method = "component", 
            weights = w, mu = m, sigma = sigma, m3 = M3.MM(edhec, as.mat = F), m4 = M4.MM(edhec, as.mat = F))
rm95[1, 1] <- temp$MVaR
VaRcomp[1,] <- temp$pct_contrib_MVaR

temp <- VaR(p = p, method = "modified", portfolio_method = "component", 
            weights = w, mu = m, sigma = sigma, m3 = M3.struct(edhec, "Indep", as.mat = F), 
            m4 = M4.struct(edhec, "Indep", as.mat = F))
rm95[2, 1] <- temp$MVaR
VaRcomp[2,] <- temp$pct_contrib_MVaR

temp <- VaR(p = p, method = "modified", portfolio_method = "component", 
            weights = w, mu = m, sigma = sigma, m3 = M3.struct(edhec, "IndepId", as.mat = F), 
            m4 = M4.struct(edhec, "IndepId", as.mat = F))
rm95[3, 1] <- temp$MVaR
VaRcomp[3,] <- temp$pct_contrib_MVaR

temp <- VaR(p = p, method = "modified", portfolio_method = "component", 
            weights = w, mu = m, sigma = sigma, m3 = M3.struct(edhec, "observedfactor", f = f, as.mat = F), 
            m4 = M4.struct(edhec, "observedfactor", f = f, as.mat = F))
rm95[4, 1] <- temp$MVaR
VaRcomp[4,] <- temp$pct_contrib_MVaR

temp <- VaR(p = p, method = "modified", portfolio_method = "component", 
            weights = w, mu = m, sigma = sigma, m3 = M3.struct(edhec, "CC", as.mat = F), 
            m4 = M4.struct(edhec, "CC", as.mat = F))
rm95[5, 1] <- temp$MVaR
VaRcomp[5,] <- temp$pct_contrib_MVaR

temp <- VaR(p = p, method = "modified", portfolio_method = "component", 
            weights = w, mu = m, sigma = sigma, m3 = M3.shrink(edhec, 1, as.mat = F)$M3sh, 
            m4 = M4.shrink(edhec, 1, as.mat = F)$M4sh)
rm95[6, 1] <- temp$MVaR
VaRcomp[6,] <- temp$pct_contrib_MVaR

temp <- VaR(p = p, method = "modified", portfolio_method = "component", 
            weights = w, mu = m, sigma = sigma, m3 = M3.shrink(edhec, 2, as.mat = F)$M3sh, 
            m4 = M4.shrink(edhec, 2, as.mat = F)$M4sh)
rm95[7, 1] <- temp$MVaR
VaRcomp[7,] <- temp$pct_contrib_MVaR

temp <- VaR(p = p, method = "modified", portfolio_method = "component", 
            weights = w, mu = m, sigma = sigma, m3 = M3.shrink(edhec, 3, f = f, as.mat = F)$M3sh, 
            m4 = M4.shrink(edhec, 3, f= f, as.mat = F)$M4sh)
rm95[8, 1] <- temp$MVaR
VaRcomp[8,] <- temp$pct_contrib_MVaR

temp <- VaR(p = p, method = "modified", portfolio_method = "component", 
            weights = w, mu = m, sigma = sigma, m3 = M3.shrink(edhec, 4, as.mat = F)$M3sh, 
            m4 = M4.shrink(edhec, 4, as.mat = F)$M4sh)
rm95[9, 1] <- temp$MVaR
VaRcomp[9,] <- temp$pct_contrib_MVaR

temp <- VaR(p = p, method = "modified", portfolio_method = "component", 
            weights = w, mu = m, sigma = sigma, m3 = M3.shrink(edhec, c(1, 3, 4), f = f, as.mat = F)$M3sh, 
            m4 = M4.shrink(edhec, c(1, 3, 4), f = f, as.mat = F)$M4sh)
rm95[10, 1] <- temp$MVaR
VaRcomp[10,] <- temp$pct_contrib_MVaR

temp <- VaR(p = p, method = "modified", portfolio_method = "component", 
            weights = w, mu = m, sigma = sigma, m3 = M3.ewma(edhec, as.mat = F), 
            m4 = M4.ewma(edhec, as.mat = F))
rm95[11, 1] <- temp$MVaR
VaRcomp[11,] <- temp$pct_contrib_MVaR

temp <- VaR(p = p, method = "modified", portfolio_method = "component", 
            weights = w, mu = m, sigma = sigma, m3 = M3.MCA(edhec, k = 1, as.mat = F)$M3mca, 
            m4 = M4.MCA(edhec, k = 1, as.mat = F)$M4mca)
rm95[12, 1] <- temp$MVaR
VaRcomp[12,] <- temp$pct_contrib_MVaR

temp <- VaR(p = p, method = "modified", portfolio_method = "component", 
            weights = w, mu = m, sigma = sigma, m3 = M3.MCA(edhec, k = 3, as.mat = F)$M3mca, 
            m4 = M4.MCA(edhec, k = 3, as.mat = F)$M4mca)
rm95[13, 1] <- temp$MVaR
VaRcomp[13,] <- temp$pct_contrib_MVaR

temp <- ES(p = p, method = "modified", portfolio_method = "component", 
           weights = w, mu = m, sigma = sigma, m3 = M3.MM(edhec, as.mat = F), m4 = M4.MM(edhec, as.mat = F))
rm95[1, 2] <- temp$MES
EScomp[1,] <- temp$pct_contrib_MES

temp <- ES(p = p, method = "modified", portfolio_method = "component", 
           weights = w, mu = m, sigma = sigma, m3 = M3.struct(edhec, "Indep", as.mat = F), 
           m4 = M4.struct(edhec, "Indep", as.mat = F))
rm95[2, 2] <- temp$MES
EScomp[2,] <- temp$pct_contrib_MES

temp <- ES(p = p, method = "modified", portfolio_method = "component", 
           weights = w, mu = m, sigma = sigma, m3 = M3.struct(edhec, "IndepId", as.mat = F), 
           m4 = M4.struct(edhec, "IndepId", as.mat = F))
rm95[3, 2] <- temp$MES
EScomp[3,] <- temp$pct_contrib_MES

temp <- ES(p = p, method = "modified", portfolio_method = "component", 
           weights = w, mu = m, sigma = sigma, m3 = M3.struct(edhec, "observedfactor", f = f, as.mat = F), 
           m4 = M4.struct(edhec, "observedfactor", f = f, as.mat = F))
rm95[4, 2] <- temp$MES
EScomp[4,] <- temp$pct_contrib_MES

temp <- ES(p = p, method = "modified", portfolio_method = "component", 
           weights = w, mu = m, sigma = sigma, m3 = M3.struct(edhec, "CC", as.mat = F), 
           m4 = M4.struct(edhec, "CC", as.mat = F))
rm95[5, 2] <- temp$MES
EScomp[5,] <- temp$pct_contrib_MES

temp <- ES(p = p, method = "modified", portfolio_method = "component", 
           weights = w, mu = m, sigma = sigma, m3 = M3.shrink(edhec, 1, as.mat = F)$M3sh, 
           m4 = M4.shrink(edhec, 1, as.mat = F)$M4sh)
rm95[6, 2] <- temp$MES
EScomp[6,] <- temp$pct_contrib_MES

temp <- ES(p = p, method = "modified", portfolio_method = "component", 
           weights = w, mu = m, sigma = sigma, m3 = M3.shrink(edhec, 2, as.mat = F)$M3sh, 
           m4 = M4.shrink(edhec, 2, as.mat = F)$M4sh)
rm95[7, 2] <- temp$MES
EScomp[7,] <- temp$pct_contrib_MES

temp <- ES(p = p, method = "modified", portfolio_method = "component", 
           weights = w, mu = m, sigma = sigma, m3 = M3.shrink(edhec, 3, f = f, as.mat = F)$M3sh, 
           m4 = M4.shrink(edhec, 3, f= f, as.mat = F)$M4sh)
rm95[8, 2] <- temp$MES
EScomp[8,] <- temp$pct_contrib_MES

temp <- ES(p = p, method = "modified", portfolio_method = "component", 
           weights = w, mu = m, sigma = sigma, m3 = M3.shrink(edhec, 4, as.mat = F)$M3sh, 
           m4 = M4.shrink(edhec, 4, as.mat = F)$M4sh)
rm95[9, 2] <- temp$MES
EScomp[9,] <- temp$pct_contrib_MES

temp <- ES(p = p, method = "modified", portfolio_method = "component", 
           weights = w, mu = m, sigma = sigma, m3 = M3.shrink(edhec, c(1, 3, 4), f = f, as.mat = F)$M3sh, 
           m4 = M4.shrink(edhec, c(1, 3, 4), f = f, as.mat = F)$M4sh)
rm95[10, 2] <- temp$MES
EScomp[10,] <- temp$pct_contrib_MES

temp <- ES(p = p, method = "modified", portfolio_method = "component", 
           weights = w, mu = m, sigma = sigma, m3 = M3.ewma(edhec, as.mat = F), 
           m4 = M4.ewma(edhec, as.mat = F))
rm95[11, 2] <- temp$MES
EScomp[11,] <- temp$pct_contrib_MES

temp <- ES(p = p, method = "modified", portfolio_method = "component", 
           weights = w, mu = m, sigma = sigma, m3 = M3.MCA(edhec, k = 1, as.mat = F)$M3mca, 
           m4 = M4.MCA(edhec, k = 1, as.mat = F)$M4mca)
rm95[12, 2] <- temp$MES
EScomp[12,] <- temp$pct_contrib_MES

temp <- ES(p = p, method = "modified", portfolio_method = "component", 
           weights = w, mu = m, sigma = sigma, m3 = M3.MCA(edhec, k = 3, as.mat = F)$M3mca, 
           m4 = M4.MCA(edhec, k = 3, as.mat = F)$M4mca)
rm95[13, 2] <- temp$MES
EScomp[13,] <- temp$pct_contrib_MES

colnames(rm95) <- c("VaR", "ES")
rownames(rm95) <- c("sample", "struct - Indep", "struct - IndepId", "struct - 1f", "struct - CC",
                    "shrink - Indep", "shrink - IndepId", "shrink - 1f", "shrink - CC", 
                    "shrink - Indep/1f/CC", "EWMA", "MCA - 1 factor", "MCA - 3 factors")


###################################################
### code chunk number 33: EWMArm
###################################################
CCVaR <- VaR(p = p, method = "modified", portfolio_method = "component", 
             weights = w, mu = m, sigma = M2.struct(edhec, "CC"), m3 = M3.struct(edhec, "CC", as.mat = F), 
             m4 = M4.struct(edhec, "CC", as.mat = F))$MVaR
CCES <- ES(p = p, method = "modified", portfolio_method = "component", 
           weights = w, mu = m, sigma = M2.struct(edhec, "CC"), m3 = M3.struct(edhec, "CC", as.mat = F), 
           m4 = M4.struct(edhec, "CC", as.mat = F))$MES


###################################################
### code chunk number 34: EWMArm
###################################################
rm95


