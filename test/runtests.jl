using UnitfulUS
using Base.Test

@testset "US string macro" begin
    @test macroexpand(:(us"gal")) == :(UnitfulUS.ustrcheck(UnitfulUS.gal_us))
    @test macroexpand(:(us"1.0")) == 1.0
    @test macroexpand(:(us"ton/gal")) == :(UnitfulUS.ustrcheck(UnitfulUS.ton_us)
        / UnitfulUS.ustrcheck(UnitfulUS.gal_us))
    @test macroexpand(:(us"1.0gal")) ==
        :(1.0 * UnitfulUS.ustrcheck(UnitfulUS.gal_us))
    @test macroexpand(:(us"gal^-1")) ==
        :(UnitfulUS.ustrcheck(UnitfulUS.gal_us) ^ -1)

    @test isa(macroexpand(:(us"ton gal")).args[1], ParseError)

    # Disallowed functions
    @test isa(macroexpand(:(us"abs(2)")).args[1], ErrorException)

    # Units not found
    @test isa(macroexpand(:(us"kg")).args[1], ErrorException)

    # test ustrcheck(x) fallback to catch non-units / quantities
    @test isa(macroexpand(:(us"ustrcheck")).args[1], ErrorException)
end
