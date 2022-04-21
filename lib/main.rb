# typed: strict
require "sorbet-runtime"
require_relative "nyan"

extend T::Sig

sig {params(str: String).returns(NilClass)}
def before(str)
    puts "before"
    main(str)
end

sig {params(name: String).returns(NilClass)}
def main(name)
    puts "Hello, #{name}!";
    Nyan.Toast()
    cat = Nyan::Cat.new
    cat.Meow()
end

main("sam")