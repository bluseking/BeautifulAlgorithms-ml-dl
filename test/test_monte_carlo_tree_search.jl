@testset "Monte Carlo tree search" begin
    import Random: seed!
    seed!(0)

    ð® = [1:100;]
    ð = [+1, -1]
    T = (s,a,sâ²) -> s + a == sâ² ? 0.7 : 0
    R = (s,a) -> s == 50 ? 1 : 0
    G = (s,a) ->  begin
        sâ² = rand([s, s+a, s-a])
        r = R(s, a)
        return (sâ², r)
    end
    ð« = MDPá´³(0.95, ð®, ð, T, R, G)

    mcts = MonteCarloTreeSearch(ð«, Dict(), Dict(), 50, 1000, 1, s->rand(map(a->s+a, ð)))

    @test mcts(1) == 1
    @test mcts(55) == 2
    @test mcts(100) == 1
end
