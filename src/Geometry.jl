module Geometry

export reshuffle, reshuffle_t

function issquare(x::Int64)
    y = isqrt(x)
    return y*y == x
end

function reshuffle_t(input)
    len,_ = size(input)
    n = len |> sqrt |> Integer
    lista = UnitRange{Int64}[]
    copia = similar(input)

    @simd for i in 1:n
        push!(lista,  (n*(i-1) + 1):n*i )
    end

    ind = 1
    @simd for i in eachindex(lista)
      @simd for j in eachindex(lista)
        @inbounds copia[lista[i],lista[j]] = reshape(input[ind,:], n, n)|> transpose
        ind += 1
      end
    end
    copia
end
function reshuffle(input)
    len,_ = size(input)
    n = len |> sqrt |> Integer
    lista = UnitRange{Int64}[]
    copia = similar(input)

    for i in 1:n
        push!(lista,  (n*(i-1) + 1):n*i )
    end

    ind = 1
    for i in lista, j in lista
        copia[i,j] = reshape(input[ind,:], n, n)|> transpose
        ind += 1
    end
    copia
end

end # module
