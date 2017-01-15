using KeyTuples
using Base.Test

macro capture_io(io, body)
    quote
        $io = IOBuffer()
        $(body)
        takebuf_string($io)
    end
end

k = KeyTuple(:a => 1, :b => "string")

@testset "constructors" begin
    @test k == KeyTuple((:a,:b),(1,"string"))
end

@testset "accessors" begin
    @test keys(k) ≡ (:a,:b)
    @test values(k) == (1,"string")
    @test k[:a] == 1
    @test k[:b] == "string"
    @test k[end] == "string"
    @test_throws BoundsError k[:c]
end

@testset "comparison" begin
    @test k == KeyTuple(:a => 1, :b => "string")
    @test k != KeyTuple(:a => 1, :c => "string")
    @test k != KeyTuple(:a => 1, :b => 2)
end
    
@testset "show" begin
    string1 = @capture_io io show(io, k)
    string2 = @capture_io io begin
        print(io, "KeyTuple")
        show(io, (:a => 1, :b => "string"))
    end
    @test string1 == string2
end

@testset "iteration" begin
    @test first(k) == (:a => 1)
    @test last(k) == (:b => "string")
    @test collect(k) == [:a => 1, :b => "string"]
end
