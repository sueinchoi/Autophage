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

10*28*1000
code <- '
'