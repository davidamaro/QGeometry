module Geometry
import RandomMatrices: Haar

export reshuffle, canalunistocastico,banano
export puntosimplejo, soportematriz, canal
export grupoHW

function issquare(x::Int64)
    y = isqrt(x)
    return y*y == x
end

function reshuffle(input)
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

function canalunistocastico(mat)
  len, _ = size(mat)
  n = len |> sqrt |> Integer

  reshuffle(mat)*conj(transpose(mat))
end

function banano()
  mat1 = rand(Haar(2), 3)
  mat2 = rand(Haar(2), 3)
  mat3 = rand(Haar(2), 3)

  mat = zeros(Complex{Float64}, 9, 9)
  mat[1:3, 1:3] = mat1
  mat[4:6, 4:6] = mat2
  mat[7:9, 7:9] = mat3

  mat
end

function canal(p₁,p₂)
    s = (3*p₁-1) + im*(p₁+2*p₂-1)
    [1 conj(s) s;
     s 1 conj(s);
     conj(s) s 1
     ]
end

function soportematriz(mat)
    abc = zeros(Complex{Float64}, 3,3)
    for (i,x) in enumerate([1,5,9]), (j,y) in enumerate([1,5,9])
        abc[i,j] = mat[x,y]
    end
    abc
end

function puntosimplejo(n)
    x = rand(Float64,n - 1)

    x = [0;x;1]

    y = x[2:end] .- x[1:end-1]

    z = rand()^(1/n)

    return y.*z
end

function genQ(n)
    ωₙ = ℯ^(2*π*im/n)
    mat::Array{Complex{Float64}, 2} = zeros(Complex{Float64},n,n)
    for i in 0:n-1
        mat[i+1,i+1] = ωₙ^i
    end
    mat
end
function genP(n)
    mat::Array{Complex{Float64}, 2} = zeros(Complex{Float64},n,n)
    for i in 1:n-1
        mat[i,i+1] = 1
    end
    mat[n,1] = 1
    mat
end
function grupoHW(n)
  genQ(n), genP(n)
end

end # module
