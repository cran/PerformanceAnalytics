

#' EDHEC-Risk Hedge Fund Style Indices
#' 
#' EDHEC composite hedge fund style index returns.
#' 
#' EDHEC Data used in PerformanceAnalytics and related publications with the
#' kind permission of the EDHEC Risk and Asset Management Research Center.
#' 
#' The 'edhec' data set included with PerformanceAnalytics will be periodically
#' updated (typically annually) to include additional observations.  If you
#' intend to use this data set in automated tests, please be sure to subset
#' your data like \code{edhec[1:120,]} to use the first ten years of
#' observations.
#' 
#' From the EDHEC website: \dQuote{The EDHEC Risk and Asset Management Research
#' Centre plays a noted role in furthering applied financial research and
#' systematically highlighting its practical uses. As part of its philosophy,
#' the centre maintains a dialogue with professionals which benefits the
#' industry as a whole. At the same time, its proprietary R&D provides sponsors
#' with an edge over competition and joint ventures allow selected partners to
#' develop new business opportunities.
#' 
#' To further assist financial institutions and investors implement the latest
#' research advances in order to meet the challenges of the changing asset
#' management landscape, the centre has spawned two consultancies and an
#' executive education arm. Clients of these derivative activities include many
#' of the leading organisations throughout Europe.}
#' 
#' see \url{http://www.edhec-risk.com/about_us}
#' 
#' @name edhec
#' @docType data
#' @format CSV conformed into an xts object with monthly observations
#' @references About EDHEC Alternative Indexes. December 16, 2003. EDHEC-Risk.
#' \cr \url{http://www.edhec-risk.com/indexes/pure_style/about}
#' 
#' Vaissie Mathieu. A Detailed Analysis of the Construction Methods and
#' Management Principles of Hedge Fund Indices. October 2003. EDHEC. \cr
#' \url{http://www.edhec-risk.com/site_edhecrisk/public/indexes/EDHEC_Publications/RISKReview1072705188065793513}
#' @source \url{http://www.edhec-risk.com/indexes/pure_style}
#' @keywords datasets ts
#' @examples
#' 
#' data(edhec)
#' 
#' #preview the data
#' head(edhec)
#' 
#' #summary period statistics
#' summary(edhec)
#' 
#' #cumulative index returns
#' tail(cumprod(1+edhec),1)
#' 
NULL





#' Hypothetical Alternative Asset Manager and Benchmark Data
#' 
#' A xts object that contains columns of monthly returns for six hypothetical
#' asset managers (HAM1 through HAM6), the EDHEC Long-Short Equity hedge fund
#' index, the S\&P 500 total returns, and total return series for the US
#' Treasury 10-year bond and 3-month bill. Monthly returns for all series end
#' in December 2006 and begin at different periods starting from January 1996.
#' 
#' Note that all the EDHEC indices are available in \code{\link{edhec}}.
#' 
#' Please note that the `managers' data set included with PerformanceAnalytics
#' will be periodically updated with new managers and information.  If you
#' intend to use this data set in automated tests, please be sure to subset
#' your data like \code{managers[1:120,1:6]} to use the first ten years of
#' observations on HAM1-HAM6.
#' 
#' @name managers
#' @docType data
#' @format CSV conformed into an xts object with monthly observations
#' @keywords datasets ts
#' @examples
#' 
#' data(managers)
#' 
#' #preview the data
#' head(managers)
#' 
#' #summary period statistics
#' summary(managers)
#' 
#' #cumulative returns
#' tail(cumprod(1+managers),1)
#' 
NULL





#' Econometric tools for performance and risk analysis.
#' 
#' \kbd{PerformanceAnalytics} provides an package of econometric functions for
#' performance and risk analysis of financial instruments or portfolios. This
#' package aims to aid practitioners and researchers in using the latest
#' research for analysis of both normally and non-normally distributed return
#' streams.
#' 
#' We created this package to include functionality that has been appearing in
#' the academic literature on performance analysis and risk over the past
#' several years, but had no functional equivalent in .  In doing so, we also
#' found it valuable to have wrappers for some functionality with good defaults
#' and naming consistent with common usage in the finance literature.
#' 
#' In general, this package requires return (rather than price) data. Almost
#' all of the functions will work with any periodicity, from annual, monthly,
#' daily, to even minutes and seconds, either regular or irregular.
#' 
#' The following sections cover Time Series Data, Performance Analysis, Risk
#' Analysis (with a separate treatment of VaR), Summary Tables of related
#' statistics, Charts and Graphs, a variety of Wrappers and Utility functions,
#' and some thoughts on work yet to be done.
#' 
#' In this summary, we attempt to provide an overview of the capabilities
#' provided by \kbd{PerformanceAnalytics} and pointers to other literature and
#' resources in useful for performance and risk analysis.  We hope that this
#' summary and the accompanying package and documentation partially fill a hole
#' in the tools available to a financial engineer or analyst.
#' 
#' 
#' @name PerformanceAnalytics-package
#' @aliases PerformanceAnalytics-package PerformanceAnalytics
#' @docType package
#' 
#' @section Time Series Data: Not all, but many of the measures in this package
#' require time series data.  \kbd{PerformanceAnalytics} uses the
#' \code{\link[xts]{xts}} package for managing time series data for several
#' reasons.  Besides being fast and efficient, \code{\link[xts]{xts}} includes
#' functions that test the data for periodicity and draw attractive and
#' readable time-based axes on charts.  Another benefit is that
#' \code{\link[xts]{xts}} provides compatability with Rmetrics'
#' \code{\link[timeSeries]{timeSeries}}, \code{\link[zoo]{zoo}} and other time
#' series classes, such that \kbd{PerformanceAnalytics} functions that return a
#' time series will return the results in the same format as the object that
#' was passed in.  Jeff Ryan and Josh Ulrich, the authors of
#' \code{\link[xts]{xts}}, have been extraordinarily helpful to the development
#' of \kbd{PerformanceAnalytics} and we are very greatful for their
#' contributions to the community.  The \code{\link[xts]{xts}} package extends
#' the excellent \code{\link[zoo]{zoo}} package written by Achim Zeileis and
#' Gabor Grothendieck. \code{\link[zoo]{zoo}} provides more general time series
#' support, whereas \code{\link[xts]{xts}} provides functionality that is
#' specifically aimed at users in finance.
#' 
#' Users can easily load returns data as time series for analysis with
#' \kbd{PerformanceAnalytics} by using the \code{\link{Return.read}} function.
#' The \code{\link{Return.read}} function loads csv files of returns data where
#' the data is organized as dates in the first column and the returns for the
#' period in subsequent columns.  See \code{\link[zoo]{read.zoo}} and
#' \code{\link[xts]{as.xts}} if more flexibility is needed.
#' 
#' The functions described below assume that input data is organized with asset
#' returns in columns and dates represented in rows.  All of the metrics in
#' \kbd{PerformanceAnalytics} are calculated by column and return values for
#' each column in the results.  This is the default arrangement of time series
#' data in \code{xts}.
#' 
#' Some sample data is available in the \code{\link{managers}} dataset. It is
#' an xts object that contains columns of monthly returns for six hypothetical
#' asset managers (HAM1 through HAM6), the EDHEC Long-Short Equity hedge fund
#' index, the S&P 500 total returns, and total return series for the US
#' Treasury 10-year bond and 3-month bill. Monthly returns for all series end
#' in December 2006 and begin at different periods starting from January 1996.
#' That data set is used extensively in our examples and should serve as a
#' model for formatting your data.
#' 
#' For retrieving market data from online sources, see \code{quantmod}'s
#' \code{\link[quantmod]{getSymbols}} function for downloading prices and
#' \code{\link[quantmod]{chartSeries}} for graphing price data.  Also see the
#' \code{tseries} package for the function
#' \code{\link[tseries]{get.hist.quote}}. Look at \code{xts}'s
#' \code{\link[xts]{to.period}} function to rationally coerce irregular price
#' data into regular data of a specified periodicity.  The
#' \code{\link{aggregate}} function has methods for \code{tseries} and
#' \code{zoo} timeseries data classes to rationally coerce irregular data into
#' regular data of the correct periodicity.
#' 
#' Finally, see the function \code{\link{Return.calculate}} for calculating
#' returns from prices.
#' @author Brian G. Peterson \cr Peter Carl \cr
#' 
#' Maintainer: Brian G. Peterson \email{brian@@braverock.com}
#' @seealso CRAN task view on Empirical Finance \cr
#' \url{http://cran.r-project.org/src/contrib/Views/Econometrics.html}
#' 
#' Grant Farnsworth's Econometrics in R \cr
#' \url{http://cran.r-project.org/doc/contrib/Farnsworth-EconometricsInR.pdf}
#' 
#' Collection of R charts and graphs \cr
#' \url{http://addictedtor.free.fr/graphiques/}
#' @references Amenc, N. and Le Sourd, V. \emph{Portfolio Theory and
#' Performance Analysis}. Wiley. 2003. \cr Bacon, C. \emph{Practical Portfolio
#' Performance Measurement and Attribution}. Wiley. 2004. \cr Canto, V.
#' \emph{Understanding Asset Allocation}. FT Prentice Hall. 2006. \cr
#' Lhabitant, F. \emph{Hedge Funds: Quantitative Insights}. Wiley. 2004. \cr
#' Litterman, R., Gumerlock R., et. al. \emph{The Practice of Risk Management:
#' Implementing Processes for Managing Firm-Wide Market Risk}. Euromoney. 1998.
#' \cr Martellini, Lionel, and Volker Ziemann. \emph{Improved Forecasts of
#' Higher-Order Comoments and Implications for Portfolio Selection.} EDHEC Risk
#' and Asset Management Research Centre working paper. 2007. \cr Ranaldo,
#' Angelo, and Laurent Favre Sr. \emph{How to Price Hedge Funds: From Two- to
#' Four-Moment CAPM.} SSRN eLibrary. 2005. Murrel, P. \emph{R Graphics}.
#' Chapman and Hall. 2006.  \cr Ruppert, D. \emph{Statistics and Finance, an
#' Introduction}. Springer. 2004. \cr Scherer, B. and Martin, D. \emph{Modern
#' Portfolio Optimization}. Springer. 2005. \cr Shumway, R. and Stoffer, D.
#' \emph{Time Series Analysis and it's Applications, with R examples},
#' Springer, 2006. \cr Tsay, R. \emph{Analysis of Financial Time Series}.
#' Wiley. 2001. \cr Zin, Markowitz, Zhao (2006)
#' \url{http://papers.ssrn.com/sol3/papers.cfm?abstract_id=910640} \cr Zivot,
#' E. and Wang, Z. \emph{Modeling Financial Time Series with S-Plus: second
#' edition}. Springer. 2006. \cr
#' @keywords package
NULL





#' Selected Price Series Example Data
#' 
#' A object returned by get.hist.quote of price data for use in the example for
#' \code{\link{Return.calculate}}
#' 
#' 
#' @name prices
#' @docType data
#' @format variable 'prices'
#' @keywords datasets ts
#' @examples
#' 
#' data(prices)
#' 
#' #preview the data
#' head(prices)
#' 
#' 
NULL





#' Selected Portfolio Weights Data
#' 
#' An xts object that contains columns of monthly weights for a subset of the
#' EDHEC hedge fund indexes that demonstrate rebalancing portfolios through
#' time.
#' 
#' Note that all the EDHEC indices are available in \code{\link{edhec}}.
#' 
#' A relatively random weights file used for charting examples.
#' 
#' @name weights
#' @docType data
#' @format CSV conformed into an xts object with monthly observations
#' @keywords datasets ts
#' @examples
#' 
#' data(weights)
#' 
#' #preview the data
#' head(weights)
#' 
#' 
NULL



