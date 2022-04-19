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



https://codeburst.io/ruby-macros-18bb67e051c7
