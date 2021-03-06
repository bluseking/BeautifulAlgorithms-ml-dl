@testset "Loss functions" begin
    x_vec = [2.3, 1.2]
    š°_vec = [0.8, 1.1]
    x_scalar = 2.3
    š°_scalar = 3
    y = 0.5
    Ļ = x->x

    @test loss_01(x_scalar, y, š°_scalar, Ļ) == 0

    for (x, š°) in zip([x_vec, x_scalar], [š°_vec, š°_scalar])
        for diff_method in [forward_difference, central_difference, backward_difference, complex_difference]
            iscomplex::Bool = diff_method == complex_difference
            @test iscomplex || isapprox(abs(sum(āloss_absdev(x, y, š°, Ļ))), abs(diff_method(š°įµ¢ -> loss_absdev(x, y, š°įµ¢, Ļ), š°)), atol=1e-2)
            @test isapprox(abs(sum(āloss_squared(x, y, š°, Ļ))), abs(diff_method(š°įµ¢ -> loss_squared(x, y, š°įµ¢, Ļ), š°)), atol=1e-2)
            @test iscomplex || isapprox(abs(sum(āloss_hinge(x, y, š°, Ļ))), abs(diff_method(š°įµ¢ -> loss_hinge(x, y, š°įµ¢, Ļ), š°)), atol=1e-2)
            @test isapprox(abs(sum(āloss_logistic(x, y, š°, Ļ))), abs(diff_method(š°įµ¢ -> loss_logistic(x, y, š°įµ¢, Ļ), š°)), atol=1e-2)
            @test isapprox(abs(sum(āloss_cross_entropy(x, y, š°, Ļ))), abs(diff_method(š°įµ¢ -> loss_cross_entropy(x, y, š°įµ¢, Ļ), š°)), atol=1e-2)
        end
    end
end
