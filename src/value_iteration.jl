struct MDP Ī³; š®; š; T; R end

function lookahead(š«::MDP, U::Vector, s, a)
    (š®, T, R, Ī³) = (š«.š®, š«.T, š«.R, š«.Ī³)
    return R(s,a) + Ī³*sum(T(s,a,sā²)*U[i] for (i,sā²) in enumerate(š®))
end

function value_iteration(š«::MDP, k_max)
    (š®, š, T, R, Ī³) = (š«.š®, š«.š, š«.T, š«.R, š«.Ī³)
    U = [0.0 for s in š®]
    for k = 1:k_max
        Uā² = [maximum(lookahead(š«, U, s, a) for a in š) for s in š®]
        U = Uā²
    end
    return U
end

policy(s; š«, U) = findmax([lookahead(š«, U, s, a) for a in š«.š])[end]