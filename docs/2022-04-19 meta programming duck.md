---
date: 2022-04-19
---

## Motivation

Reading about Ruby's [Sorbet](https://stripe.com/blog/sorbet-stripes-type-checker-for-ruby) made me curious about meta-programming in ruby and how well the tooling works with the meta-programming.

A few things to clear up
- what meta-programming features does ruby have
  - syntactic macros? A: nope
  - reflection/introspection (I know it has this for sure)
  - aspect-orientation decorators or proxies
    - probably has this because I think Social Assurance uses AOP
    - A: https://gist.github.com/unit432/d665a5c977032c3b55ee202fc6525304#file-04-dynamic-proxies-rb

Also need to figure out some basic ruby tooling
- [x] what's expected in a basic ruby project (looks like I at least need a gem file for Sorbet)
- [x] debugging support
- [x] test ui integration (running rspec in console wouldn't be bad)


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

Q: Sorbet always shows as "Restarting" in the vs code bottom ribbon. I don't think I'm getting it's editor support. Why could be the issue?
- Running in WSL?
  - it is installed/enabled in both WSL and this workspace
- Can I get logs? yes, via sorbet selection in console output
  - `can't find executable srb for gem sorbet` looks like the error I got trying to run via bundle
  - yup `bundler: failed to load command: srb (/home/farlee2121/gems/bin/srb)` is also in the trace
- Can I set the srb command? Or do I need to restart to get the right path?
  - can't set the command, but there is an "enabled" toggle that wasn't set...
  - updating gem version didn't work https://stackoverflow.com/questions/55381711/msfconsole-pop-out-an-error-bundler-faild-to-load-cannot-load-such-file-b
  - maybe the bundle gem version?
  - !!! interesting, it appears that I got a different version with bundle add than I did with gem install. Bundle exec is meant to execute with of the gems of the current context's gem file, so it was getting an older version that apparently didn't have the srb command. Meanwhile the newer version had registered the srb command in my normal path. 
- New error: `Error running Watchman (with ``watchman -j -p --no-pretty``)`
  - watchman is not a gem. It needs to be installed at the system level 
  - https://github.com/sorbet/sorbet/issues/1758
  - https://facebook.github.io/watchman/docs/install.html


## Meta-programming Exploration
Most notes are in my reading notes for https://codeburst.io/ruby-macros-18bb67e051c7

One of the most helpful resources was this collection of examples https://gist.github.com/unit432/d665a5c977032c3b55ee202fc6525304

Basically, Ruby is not a symbolic language like lisp. Most meta programming is accomplished by dynamically adding methods or through certain language event hooks (e.g. method_missing). 
Dynamically declaring classes doesn't have much point because ruby is structural anyways. 

Also, ruby is more strict about object encapsulation. it discourages exposed class data and expects you to expose any instance state via methods.

Side note: i don't know what blocks were intended to add to the language. It's like the template pattern, but for methods

Ruby does support variadic methods
- https://stackoverflow.com/questions/4967735/ruby-method-with-maximum-number-of-parameters
- can't seem to find the source that talked about `**kwargs`, but you can use that to get just keyword arguments

## convention notes
the standard casing seems to be snake case

`name=` is how names are specified
Ruby allows a variety of special characters in names like `?`

## Sorbet exploration

I'm not finding any docs on how macros are handled...

Some other cool things I found
- [unions](https://sorbet.org/docs/union-types)
- [exhaustiveness checking](https://sorbet.org/docs/exhaustiveness)
- [intersection types](https://sorbet.org/docs/intersection-types) 
  - basically an "and" generic constraint

A quick experiment seems to show Sorbet does not handle dynamically added methods.
I suppose the [original article](https://stripe.com/blog/sorbet-stripes-type-checker-for-ruby) did say "metaprogramming is very opaque"

I think sorbet should still work for proxies and any method that have an clear def that could be annotated