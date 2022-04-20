# typed: strict
require "sorbet-runtime"
require_relative "nyan"

extend T::Sig

sig {params(name: String).returns(NilClass)}
def main(name)
    puts "Hello, #{name}!";
    Nyan.Toast()
end

main("sam")