\name{PMD.cv}
\alias{PMD.cv}
\title{Do tuning parameter selection for PMD via cross-validation}
\description{
Performs cross-validation to select tuning parameters for rank-1 PMD, the penalized matrix decomposition for a data matrix. 
}
\usage{
PMD.cv(x, type=c("standard", "ordered"), sumabss=seq(0.1,0.7,len=10),
sumabsus=NULL, lambda=NULL, nfolds=5, niter=5, v=NULL, chrom=NULL, nuc=NULL,
trace=TRUE, center=TRUE, upos=FALSE, uneg=FALSE, vpos=FALSE, vneg=FALSE)
}
\arguments{
  \item{x}{Data matrix of dimension $n x p$, which can contain NA
    for missing values. }
  \item{type}{"standard" or "ordered": Do we want v to simply be sparse,
    or should it also be smooth? If the columns of x are ordered
    (e.g. CGH spots along a chromosome) then choose "ordered". Default
    is "standard". If "standard", then the PMD function will make use of
    sumabs OR
    sumabsu&sumabsv. If "ordered", then the function will make use of
    sumabsu and lambda.}
  \item{sumabss}{Used only if type is "standard". A vector of sumabs
    values to be used. Sumabs is a measure of sparsity for u and v vectors, between 0 and
    1. When sumabss is specified, and sumabsus and sumabsvs are NULL, then
    sumabsus is set to $sqrt(n)*sumabss$ and sumabsvs is set at
    $sqrt(p)*sumabss$. If sumabss is specified, then sumabsus and sumabsvs
    should be NULL. Or if sumabsus and sumabsvs are specified, then sumabss
  should be NULL.}
  \item{sumabsus}{Used only for type "ordered". A vector of sumabsu
    values to be used. Sumabsu measures sparseness of u - it is the sum
    of absolute values of elements of u. Must be between 1 and sqrt(n). }
  \item{lambda}{Used only if type is "ordered". This is the tuning
    parameter for the fused lasso penalty on v, which takes the form
    $lambda ||v||_1 + lambda |v_j - v_(j-1)|$. $lambda$ must be
    non-negative. If NULL, then it is chosen adaptively from the data.}
  \item{nfolds}{How many cross-validation folds should be performed?
    Default is 5.}
    \item{niter}{How many iterations should be performed. For speed,
      only 5 are performed by default.}
  \item{v}{The first right singular vector(s) of the data. (If missing
    data is present, then the missing values are imputed before the
    singular vectors are calculated.) v is used as the initial value for
    the iterative PMD algorithm. If x is large, then this
    step can be time-consuming; therefore, if PMD is to be run multiple
    times, then v should be computed once and saved.}
  \item{chrom}{If type is "ordered", then this gives the option to
    specify that some columns of x (corresponding to CGH spots) are on
    different chromosomes. Then v will be sparse, and smooth *within*
    each chromosome but not *between* chromosomes. Length of chrom
    should equal number of columns of x, and each entry in chrom should
    be a number corresponding to which chromosome the CGH spot is on.}
  \item{nuc}{If type is "ordered", can specify the nucleotide position
    of each CGH spot (column of x), to be used in plotting. If NULL,
    then it is assumed that CGH spots are equally spaced.}
    \item{trace}{Print out progress as iterations are performed? Default
    is TRUE.}
  \item{center}{Subtract out mean of x? Default is TRUE}
  \item{upos}{Constrain the elements of u to be positive? TRUE or
    FALSE.}
  \item{uneg}{Constrain the elements of u to be negative? TRUE or
    FALSE.}
  \item{vpos}{Constrain the elements of v to be positive? TRUE or
    FALSE. Cannot be used if type is "ordered".}
  \item{vneg}{Constrain the elements of v to be negative? TRUE or
    FALSE. Cannot be used if type is "ordered."}
}
\details{
If type is "standard", then lasso ($L_1$) penalties (promoting sparsity) are placed on u and
v. If type is "ordered", then lasso penalty is placed on u and a fused
lasso penalty (promoting sparsity and smoothness) is placed on v. 

Cross-validation of the rank-1 PMD is performed over sumabss (if type is "standard") or
over sumabsus (if type is "ordered"). If type is "ordered", then lambda
is chosen from the data without cross-validation.

The cross-validation works as follows: Some percent of the elements of
$x$ is  removed at random from the data matrix. The
PMD is performed for a range of tuning parameter values on this
partially-missing data matrix; then, missing values are imputed using
the decomposition obtained. The value of the tuning parameter that
results in the lowest sum of squared errors of the missing values if
"best".

To do cross-validation on the rank-2 PMD, first the rank-1 PMD should be
computed, and then this function should be performed on the residuals,
given by $x-udv'$.     
}
\value{
  \item{cv}{Average sum of squared errors obtained over cross-validation
    folds.}
  \item{cv.error}{Standard error of average sum of squared errors
    obtained over cross-validation folds.}
  \item{bestsumabs}{If type="standard", then value of sumabss resulting
    in smallest CV error is returned.}
  \item{bestsumabsu}{If type="ordered", then value of sumabsus resulting
    in smallest CV error is returned.}
  \item{v.init}{The first right singular vector(s) of the data; these
    are returned to save on computation time if PMD will be run again.}
}
\references{Witten, DM and Tibshirani, R and T Hastie (2008) A penalized
  matrix decomposition, with applications to
  sparse principal components and canonical correlation
  analysis. Submitted. <http://www-stat.stanford.edu/~dwitten>}
\author{Daniela M. Witten and Robert Tibshirani}
\seealso{\link{PMD},  \link{SPC}}
\examples{

# See examples in PMD help file


}

