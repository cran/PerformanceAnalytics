`chart.RegressionDiagnostics` <-
function (R, Rb)
{ # @author Peter Carl

x = checkDataMatrix(R)
y = checkDataMatrix(Rb)

par(mfrow = c(3, 2), cex = 0.7)

chart.Histogram(x)
chart.QQPlot(x)
chart.Histogram(y)
chart.QQPlot(y)

chart.Boxplot(as.data.frame(cbind(x,y)))
plot(x~y)

}

###############################################################################
# R (http://r-project.org/) Econometrics for Performance and Risk Analysis
#
# Copyright (c) 2004-2007 Peter Carl and Brian G. Peterson
#
# This library is distributed under the terms of the GNU Public License (GPL)
# for full details see the file COPYING
#
# $Id: charts.RegressionDiagnostics.R,v 1.2 2007/02/07 13:24:49 brian Exp $
#
###############################################################################
# $Log: charts.RegressionDiagnostics.R,v $
# Revision 1.2  2007/02/07 13:24:49  brian
# - fix pervasive comment typo
#
# Revision 1.1  2007/02/02 19:06:15  brian
# - Initial Revision of packaged files to version control
# Bug 890
#
###############################################################################