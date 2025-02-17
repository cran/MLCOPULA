#' @title Joe copula joint density
#' @description Returns the joint density in tree for some copula.
#' @param theta Copula parameters.
#' @param arbol Dataframe with the results of the minimum expansion tree.
#' @param U Values of u and v.

join.joe <- function(theta,arbol,U){
  from <- arbol$from
  to <- arbol$to
  
  ncop <- dim(arbol)[1]
  
  join <- matrix(nrow = nrow(U), ncol = ncop)
  
  par <- theta[from[1],to[1]]
  copula <- joeCopula(param = par, dim = 2)
  join[,1] <- dCopula(U[,c(from[1],to[1])],copula)

  if(ncop > 1){
      for (c in 2:ncop) {
        par <- theta[from[c],to[c]]
        copula <- joeCopula(param = par, dim = 2)
        join[,c] <- dCopula(U[,c(from[c],to[c])],copula)
      }
    }
  
  join[join == 0] <- 1e-200
  den <- apply(join, 1, function(x)  sum(log(x)) )
  return(den)
}
