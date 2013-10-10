#![Shard logo](https://raw.github.com/mark/shard/master/resources/logo.shard.png) shard

*What is shard?*

Shard is a light-weight code loading-and-running-and-sharing tool, built on top of [gist](http://gist.github.com).

You can load the shard's code using a `#shard` method, and can load, run, and test a shard directly from the command line.

*So it's like gems?*

Definitely similar.  But it's a lot more lightweight—which has some pros, and some cons.  You don't get any dependency or version management, you don't get binaries, you don't get folders of files.  But in exchange, you don't need to register or push them anywhere.  You don't have to worry about name collisions.  And you can run and test them directly from the command line.

Plus, since it's built on top of gist, they're easy to read, easy to edit, and they get stars, comments, and forks.

Think of them as `gem`'s little brother.

*What if I want something a little… more?*

Shards are supposed to be light on features and requirements.  So if you find that one of your shards needs to expand out more, turn it in to a gem.

## Using shards

First, you need to install `shard` via:

`gem install shard`

That gives you the `shard` library & binary.  From there, there are two ways to use `shard`: inside another Ruby file, and from the command line.

### Shards on the command line

The shard binary gives you a number of command line functions to find, load, and run shards:

**$ shard list *username***

Displays a list of all of the shards for the named github user.

```
~ markjosef$ shard list shard-test
Shards for Github user shard-test:

6878244:
  Description | This shard does not have a descriptive shard name
  URL         | https://gist.github.com/6878244

basic:
  Description | Shard: sample shard
  URL         | https://gist.github.com/6858751

long_history:
  Description | Shard: sample shard with long history
  URL         | https://gist.github.com/6860455

multiple_files:
  Description | Shard: multiple files sample
  URL         | https://gist.github.com/6858906
```

**$ shard fetch *username/shard***

This downloads the code for the named shard, and saves it in `~/.shard/username/shard/HEAD/`.  This will always fetch a fresh version of the source.

**$ shard exec *username/shard***

This runs the named shard.  If it hasn't been saved to your machine, it will first download it.  Then it loads the shard file, printing all of the output.

```
~ markjosef$ shard exec shard-test/basic
Hello, world!
Hello, yourself!
```


**$ shard test *username/shard***

This runs the named shard—but instead of running the *shardname*.shard.rb file, it runs all of the *_test.rb and *_spec.rb files.  (You can control when your shard file gets loaded by manually requiring it via `require_relative`).

```
~ markjosef$ shard test mark/pointer
Run options: --seed 55298

# Running:

.....

Finished in 0.002799s, 1786.3523 runs/s, 1786.3523 assertions/s.

5 runs, 5 assertions, 0 failures, 0 errors, 0 skips
```

### Shards inside your ruby code

Much like the `require` and `gem` commands, you can load a shard file from inside any Ruby code using:

`shard 'mark/pointer'`

```ruby
gem 'shard'
shard 'mark/pointer'

result = Pointer.new('foo').tapp do |ptr|
  puts ~ptr
  ptr <= 'bar'
  puts ~ptr
 end
 
 puts "Result = #{ result }"
```

will output:

```
foo
bar
Result = bar
```

## Creating shards

Creating a new shard is easy: just create a public gist, and call one of the files *something*.shard.rb

For instance, if I create a new gist, and one of the files is called `pointer.shard.rb`, then anyone looking at my shards will see one listed named `pointer`.

If you want to include multiple ruby files in your shard, use `require_relative` inside your shard file to load other ruby files in the same shard.

If you want to be able to test your shard from the command line, name one of the files *something*_test.rb or *something*_spec.rb.  You can load whatever testing framework you want, but make sure to include your main shard file using `require_relative`.




