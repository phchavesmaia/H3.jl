module test_h3_lib_vertexes

using Test
using H3.API
using H3.Lib

# issue 35
@testset "Buffer overwrite bug" begin

pentagon = H3Index(0x08009fffffffffff)
n = getNumVertexes(pentagon)                # 5
buf = fill(typemax(H3Index), n + 1)         # n real slots + 1 canary sentinel
GC.@preserve buf Lib.cellToVertexes(pentagon, pointer(buf))

@test buf[6] == Lib.H3_NULL
#=
if buf[n + 1] != typemax(H3Index)
    println("overflow: C wrote slot $(n+1), past the $n-slot buffer H3.jl allocates")
else
    println("no overflow")
end
=#

end # @testset "Buffer overwrite bug"

end # module test_h3_lib_vertexes
