# typed: strict
require "sorbet-runtime"

extend T::Sig

sig {params(name: String).returns(NilClass)}
def main(name)
    puts "Hello, #{name}!";
end

main("sam")