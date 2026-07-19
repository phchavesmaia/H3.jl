module test_h3_lib_vertexes

using Test
using H3.Lib
using .Lib: H3Index

# issue 35
@testset "Buffer overwrite bug" begin

pentagon = H3Index(0x08009fffffffffff)
n = Lib.NUM_HEX_VERTS                       # 6
buf = fill(typemax(H3Index), n + 1)         # n real slots + 1 canary sentinel
GC.@preserve buf Lib.cellToVertexes(pentagon, pointer(buf))
@test buf[n] == Lib.H3_NULL
@test buf[n + 1] == typemax(H3Index) # verify not written past end - no overflow

end # @testset "Buffer overwrite bug"

end # module test_h3_lib_vertexes
