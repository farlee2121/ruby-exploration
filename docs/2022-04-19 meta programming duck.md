---
date: 2022-04-19
---

## Motivation

Reading about Ruby's [Sorbet](https://stripe.com/blog/sorbet-stripes-type-checker-for-ruby) made me curious about meta-programming in ruby and how well the tooling works with the meta-programming.

A few things to clear up
- what meta-programming features does ruby have
  - syntactic macros?
  - reflection/introspection (I know it has this for sure)
  - aspect-orientation decorators or proxies
    - probably has this because I think Social Assurance uses AOP

Also need to figure out some basic ruby tooling
- what's expected in a basic ruby project (looks like I at least need a gem file for Sorbet)
- debugging support
- test ui integration (running rspec in console wouldn't be bad)


## Exploration
Meta-programming: https://codeburst.io/ruby-macros-18bb67e051c7

ruby basics: https://www.tutorialspoint.com/ruby/index.htm

Some standard ruby project setup https://stackoverflow.com/questions/9549450/how-do-i-set-up-a-basic-ruby-project
- hmm looks like I should have used `bundle gem name-here` to template
- the other step is `rspec --init`

Looks like debug support requires some gems
- https://github.com/rubyide/vscode-ruby/blob/main/docs/debugger.md

Next, setting up sorbet
- Sorbet doesn't support windows ;-; https://sorbet.org/docs/faq#what-platforms-does-sorbet-support 


I had a hard time getting require to work. This article helps https://stackoverflow.com/questions/9750610/ruby-require-error-cannot-load-such-file
- by default, it expects a path relative to some dir in the LOAD_PATH, which I thought I was doing
- `require_relative` ended up being a simpler solution

Module quirk: Ruby examples show `def ModuleName.methodName()` for defining methods. Sorbet expects `def self.methodName()` 
- looks like self is a special keyword. You cannot use other identifier expressions like in F#

Q: Do cross-module calls (like instantiating `Cat`) need to be fully qualified?

