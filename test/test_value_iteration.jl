@testset "Value iteration" begin
    P = MDP(0.95, [1:100;], [+1, -1], (s,a,sā²)->s + a == sā² ? 0.7 : 0, (s,a)->s == 50 ? 1 : 0)

    U = value_iteration(P, 100)

    reshape(U, 10, 10)

    # Optimal policy (š = [+1, -1])
    @test all(policy.(1:50, š«=P, U=U) .== 1) # go forwards toward 50
    @test all(policy.(51:100, š«=P, U=U) .== 2) # go backwards toward 50
end
