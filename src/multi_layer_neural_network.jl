using LinearAlgebra

function multi_layer_neural_network(x, ๐, ฯ, ๐ )
    ๐กแตข = ฯ(x)
    for (i,g) in enumerate(๐ )
        ๐กแตข = map(๐ฐโฑผ -> g(๐ฐโฑผ โ ๐กแตข), ๐[i])
    end
    ๐กแตข โ last(๐)
end