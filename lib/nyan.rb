# typed: true
require "sorbet-runtime"

module Nyan
    
    def self.Toast()
        puts "toast"
    end
    
    class Cat
        extend T::Sig
        def initialize
            
        end
        
        sig {returns(NilClass)}
        def Meow()
            puts "meow"
        end

        sig {params(name: Symbol).returns(T.untyped)}
        def self.such_macro(name)
            define_method(name) do
                puts "such_macro"
            end
        end

        # sig {returns(NilClass)}
        such_macro(:eat)
    end
end