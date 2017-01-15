module KeyTuples

export KeyTuple

"""
Tuple-like type with keys for accessing elements. Valid keys are
symbols. Use the constructor
```julia
KeyTuple(:a => 1, :b => 2)
```
to create objects.
"""
immutable KeyTuple{K,T <: Tuple} <: Associative
    values::T
    function KeyTuple(values::T)
        isa(K, Tuple{Vararg{Symbol}}) ||
            throw(ArgumentError("Keys need to be a tuple of symbols."))
        length(K) == length(values) ||
            throw(ArgumentError("Length mismatch between keys and values."))
        new{K,T}(values)
    end
end

KeyTuple{T <: Tuple}(keys::Tuple{Vararg{Symbol}}, values::T) =
    KeyTuple{keys,T}(values)

function KeyTuple(key_value_pairs::Pair...)
    keys = tuple(map(first, key_value_pairs)...)
    values = tuple(map(last, key_value_pairs)...)
    KeyTuple{keys,typeof(values)}(values)
end

function Base.show{K,T}(io::IO, x::KeyTuple{K,T})
    print(io, "KeyTuple")
    show(io, tuple([Pair(key, value) for (key, value) in zip(K, x.values)]...))
end

Base.keys{K,T}(x::KeyTuple{K,T}) = K

Base.values(x::KeyTuple) = x.values

Base.getindex{K,T}(x::KeyTuple{K,T}, index) = getindex(x.values, index)

function Base.getindex{K,T}(x::KeyTuple{K,T}, key::Symbol)
    i = findfirst(K, key)
    i == 0 && throw(BoundsError("no key $(key)"))
    x.values[i]
end

Base.length{K,T}(::KeyTuple{K,T}) = length(K)

Base.start(x::KeyTuple) = 1

Base.done{K,T}(x::KeyTuple{K,T}, iter) = iter > length(K)

Base.next{K,T}(x::KeyTuple{K,T}, iter) = (Pair(K[iter], x.values[iter]), iter + 1)

Base.endof(x::KeyTuple) = length(x)

Base.first{K,T}(x::KeyTuple{K,T}) = Pair(K[1], x.values[1])

Base.last{K,T}(x::KeyTuple{K,T}) = Pair(K[end], x.values[end])

function Base.:(==){Kx,Tx,Ky,Ty}(x::KeyTuple{Kx,Tx}, y::KeyTuple{Ky,Ty})
    (Kx == Ky) && (x.values == y.values)
end

Base.hash{K,T}(x::KeyTuple{K,T}, h::UInt) = hash(x.values, hash(K, hash(:KeyTuple, h)))

end # module
