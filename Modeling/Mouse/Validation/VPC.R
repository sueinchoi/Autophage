library(mrgsolve)

mod <- mread_cache('pk2', modlib())
see(mod)

mod <- param(mod, list(CL = 252,
                       VC = 28.6,
                        VP = 741,
                        Q = 704,
                        KA = 0.199)
                        )
mod %>%
    ev(amt = 10*28*0.214*1000) %>%
    mrgsim(end = 24) %>%
    plot()
a <- c(229.5/15.2, 369/15.1, 105.9/1.78, 79.8/2.06)
ifelse(5 %in% c(4, 5), 1:2, 1)
mean(a)
16801.28/mean(a)
10*28*1000
code <- '
'
