using LinearAlgebra

ð(b) = b ? 1 : 0
Ï(z) = 1/(1 + exp(-z))

yÌ(x, ð°, Ï, g=ð±->ð±)           = g(ð°âÏ(x))
margin(x, y, ð°, Ï, g=ð±->ð±)   = yÌ(x, ð°, Ï, g)*y
residual(x, y, ð°, Ï, g=ð±->ð±) = yÌ(x, ð°, Ï, g) - y

loss_01(x, y, ð°, Ï)       = ð(margin(x, y, ð°, Ï) â¤ 0)
loss_absdev(x, y, ð°, Ï)   = abs(residual(x, y, ð°, Ï))
loss_squared(x, y, ð°, Ï)  = residual(x, y, ð°, Ï)^2
loss_hinge(x, y, ð°, Ï)    = max(1 - margin(x, y, ð°, Ï), 0)
loss_logistic(x, y, ð°, Ï) = log(1 + exp(-margin(x, y, ð°, Ï)))
loss_cross_entropy(x, y, ð°, Ï) = -(y*log(yÌ(x, ð°, Ï, Ï)) + (1-y)*log(1-yÌ(x, ð°, Ï, Ï)))

âloss_absdev(x, y, ð°, Ï)   = Ï(x)*residual(x, y, ð°, Ï) / abs(residual(x, y, ð°, Ï))
âloss_squared(x, y, ð°, Ï)  = 2residual(x, y, ð°, Ï)*Ï(x)
âloss_hinge(x, y, ð°, Ï)    = margin(x, y, ð°, Ï) < 1 ? -Ï(x)*y : 0
âloss_logistic(x, y, ð°, Ï) = -Ï(x)*y / (exp(margin(x, y, ð°, Ï)) + 1)
âloss_cross_entropy(x, y, ð°, Ï) = Ï(x) .â residual(x, y, ð°, Ï, Ï)'