@testset "Particle filter" begin
    using Random
    Random.seed!(228)

    # POMDP setup
    Ī³ = 0.95
    š® = -10:10
    š = Normal(0, 1)
    šŖ = Uniform(-10, 10)
    transition = (s,a) -> clamp(s+a, minimum(š®), maximum(š®))
    T = (s,a) -> Normal(transition(s,a), abs(a))
    R = (s,a) -> 4 < s < 6 ? 100 : 0
    observation = (sā²,a) -> Normal(sā², abs(a))
    O = (a,sā²,o) -> pdf(observation(sā²,a), o)
    š« = POMDP(Ī³, š®, š, šŖ, T, R, O)

    # Particle filter updating with random 1D walking agent
    belief = rand(š®, 1000)
    o = rand(šŖ)
    s = o
    for i in 1:2000
        a = rand(š)
        s = transition(s,a)
        o = rand(observation(s,a))
        belief = particle_filter(belief, š«, a, o)
        Ī¼_b = mean(belief)
        Ļ_b = std(belief)
        belief_error = abs(Ī¼_b - s)
        @test (Ī¼_b-3Ļ_b ā¤ s ā¤ Ī¼_b+3Ļ_b) || belief_error ā¤ 1.0
    end
end
