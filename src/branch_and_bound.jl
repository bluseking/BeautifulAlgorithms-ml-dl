struct MDP Ī³; š®; š; T; R end

function branch_and_bound(š«::MDP, s, d, šā, šā»)
    (š®, T, R, Ī³) = (š«.š®, š«.T, š«.R, š«.Ī³)
    if d ā¤ 0
        return (a=nothing, u=šā(s))
    end
    best = (a=nothing, u=-Inf)
    šā² = s -> branch_and_bound(š«, s, d-1, šā, šā»).u
    for a in š«.š
        if šā»(s,a) < best.u
            return best # prune
        end
        u = R(s,a) + Ī³*sum(T(s,a,sā²)*šā²(sā²) for sā² in š®)
        if u > best.u
            best = (a=a, u=u)
        end
    end
    return best
end