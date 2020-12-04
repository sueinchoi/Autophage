library(tidyverse)

mouse <- c(0.249, 0.0697, 0.256, 0.0164)
rat <- c(0.966, 0.106, 0.611, 3.97)
monkey <- c(4.72, 4.15, 1.34, 0.241)

WT <- c(0.028, 0.223, 2.31)
brW <- c(0.00036, 0.0018, 0.04158)
mlp <- c(2.7, 4.7, 22)

animals <- rbind(mouse, rat, monkey) 
colnames(animals) <- c("CL", "V2", "V3", "Q")
animals_simple <- log(animals) %>% as.data.frame()
animals_brain <- animals %>% map(~.x*brW) %>% map_df(log) %>% as.data.frame()
animals_mlp <- animals %>% map(~.x*mlp) %>% map_df(log) %>% as.data.frame()

animals_simple %>%
    map(~lm(.x ~ log(WT))) %>%
    map(summary) %>%
    map('r.squared')
animals_brain %>%
    map(~lm(.x ~ log(WT))) %>%
    map(summary) %>%
    map('r.squared')

animals_mlp %>%
    map(~lm(.x ~ log(WT))) %>%
    map(summary) %>%
    map('r.squared')

best_data <- animals_brain
final <- c()

for(i in 1:length(colnames(best_data))) {
    m <- lm(best_data[, i] ~ log(WT))
    p <- predict(m, newdata = data.frame(WT = 70))
    final <- c(final, exp(p))
}
names(final) <- colnames(animals_simple)

final/1.4
final/93

lm_eqn <- function(df){
    m <- lm(y ~ x, df);
    eq <- substitute(italic(y) == a + b %.% italic(x)*","~~italic(r)^2~"="~r2, 
         list(a = format(unname(coef(m)[1]), digits = 4),
              b = format(unname(coef(m)[2]), digits = 4),
             r2 = format(summary(m)$r.squared, digits = 4)))
    as.character(as.expression(eq));
}

p1 <- p + geom_text(x = 25, y = 300, label = lm_eqn(df), parse = TRUE)
df <- data.frame(x = log(WT), y = animals_simple$CL)
df %>%
    ggplot(aes(x = x, y = y)) +
    geom_point() + 
    geom_smooth(method = 'lm', color = 'black', formula = y ~ x) +
    geom_text(x = -2, y = 1, label = lm_eqn(df), parse = TRUE)

ggsave()
 

