"""
Degree mixing matrix (a.k.a. degree correlation matrix)
"""
function degree_mixing_matrix(g::LightGraphs.SimpleGraphs.AbstractSimpleGraph; normalize=true)
# Should probably error on DiGraph as they're badly handled
    I = Array{Int64,1}()
    J = Array{Int64,1}()
    V = 1
    for (node, neighbours) in enumerate(g.fadjlist)
        for neighbour in neighbours # Each row of I,J,K corresponds to a single link
            push!(I,degree(g,node))
            push!(J,degree(g,neighbour))
        end
    end

    # Elementwise: degmat[i,j] = sum([V[k] for all k such that I[k]=i,J[k]=j])
    degmat = sparse(I,J,V)

    normalize ? degmat ./ sum(degmat) : degmat
end
