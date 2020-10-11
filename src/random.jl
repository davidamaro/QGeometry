function int2bits(i,n)
  output = zeros(Int8, n)
  for j in 1:n
    output[j] = i & 1
    i >>= 1
  end
  output
end

function inner(v,w)
  t = 0
  #for i in 0:( length(v) >> 1 ) - 1
  for i in 1:( length(v) >> 1 )
    t += v[ 2*i-1 ]*w[ 2*i ]
    t += w[ 2*i-1 ]*v[ 2*i ]
  end
  t % 2
end

function findtransvection(x,y)
    output = zeros(Int8, (2,length(x)))
    if x == y
        return output
    end

    if inner(x,y)==1
        output[1,:] = (x+y)%2
        return output
    end


    #find a pair where they are both not 00
    z = zeros(Int8, length(x) )
    #for i in range(0,size(x)>>1):
    for i in 1:length(x)>>1
        ii=2*i-1
        if ((x[ii]+x[ii+1]) != 0) && ((y[ii]+y[ii+1]) != 0)
                                        #found the pair
            z[ii] = (x[ii]+y[ii])%2
            z[ii+1] = (x[ii+1]+y[ii+1])%2
            if (z[ii]+z[ii+1])==0
                z[ii+1]=1
                if x[ii]!=x[ii+1]
                    z[ii]=1
                end
            end
            output[1,:]=(x+z)%2
            output[2,:]=(y+z)%2
            return output
        end
    end

    #for i in range(0,size(x)>>1)
    for i in 1:length(x)>>1
        ii=2*i-1
        if ((x[ii]+x[ii+1]) != 0) && ((y[ii]+y[ii+1]) == 0)
            if x[ii]==x[ii+1]
                z[ii+1]=1
            else
                z[ii+1]=x[ii]
                z[ii]=x[ii+1]
            end
        end
    end

    #for i in range(0,size(x)>>1):
    for i in 1:length(x)>>1
        ii=2*i-1
        if ((x[ii]+x[ii+1]) == 0) && ((y[ii]+y[ii+1]) != 0)
            if y[ii] == y[ii+1]
                z[ii+1]=1
            else
                z[ii+1]=y[ii]
                z[ii]=y[ii+1]
            end
        end
    end

    output[1,:] = (x+z).%2
    output[2,:] = (y+z).%2
    return output
end


# pendiente #function findtransvection(x,y)
# pendiente #
# pendiente #end
