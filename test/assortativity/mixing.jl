using Test
using LightGraphs

# Number of edges in mixing matrix should be double number of edges
# in undirected graph with no self-loops
const g = barabasi_albert(1000,4)
@test degree_mixing_matrix(g; normalize=false) |> sum == 2 * length(edges(g))

# Totally homogenous graph should only have one entry
@test length(filter(x->x!=0,degree_mixing_matrix(complete_graph(1_000)))) == 1

# Verified by manual calculation
const toyg = Graph(
    [0 1 1;
     1 0 0;
     1 0 0]
)
@test degree_mixing_matrix(toyg;normalize=false) |> Matrix == [0 2; 2 0]
