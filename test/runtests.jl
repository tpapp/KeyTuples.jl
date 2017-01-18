using KeyTuples
using Base.Test
import DataFrames

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

@testset "dataframe conversion" begin
    kts = [KeyTuple(:a => i, :b => string(i)) for i in 1:5]
    df = keytuples_to_df(kts)
    df2 = DataFrames.DataFrame(a=collect(1:5), b=string.(1:5))
    @test isequal(df, df2)
end
