@testset "Branch and bound" begin
    Ī³ = 0.95
    š® = 1:10
    š = [+1, -1]
    T = (s,a,sā²)->s + a == sā² ? 0.7 : 0
    R = (s,a)->s == 5 ? 100 : 0
    š« = BranchAndBound.MDP(Ī³, š®, š, T, R)

    d = 4 # depth
    šā = s->0 # lower bound on value function at depth d
    šā» = (s,a)->100 # upper bound on action-value function
    Ļ = s -> branch_and_bound(š«, s, d, šā, šā»).a

    for s in š®
        a = s ā¤ 5 || s ā [9, 10] ? +1 : -1
        @test Ļ(s) == a
    end
end
