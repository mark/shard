#![Shard logo](https://raw.github.com/mark/shard/master/resources/logo.shard.png) shard

[![Gem Version](https://badge.fury.io/rb/shard.png)](http://badge.fury.io/rb/shard)

1. [Using shards](#using-shards)
1. [Creating shards](#creating-shards)

*What is shard?*

Shard is a light-weight code loading-and-running-and-sharing tool, built on top of [gist](http://gist.github.com).

You can load the shard's code using a `#shard` method, and can load, run, and test a shard directly from the command line.

*So it's like gems?*

Definitely similar.  But it's a lot more lightweight—which has some pros, and some cons.  You don't get any dependency or version management, you don't get executables, you don't get folders of files.  But in exchange, you don't need to register or push them anywhere.  You don't have to worry about name collisions.  And you can run and test them directly from the command line.

Plus, since it's built on top of gist, they're easy to read, easy to edit, and they get stars, comments, and forks.

Think of them as `gem`'s baby brother.

*What if I want something a little… more?*

Shards are supposed to be light on features and requirements.  So if you find that one of your shards needs to expand out more, turn it in to a gem.

## Using shards

First, you need to install the `shard` gem via:

`gem install shard`

That gives you the `shard` library & executable.  From there, there are two ways to use `shard`: inside another Ruby file, and from the command line.

### Shards on the command line

The shard executable gives you a number of command line functions to find, load, and run shards:

__$ shard list *username*__

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

__$ shard *username/shard*__

This runs the named shard.  If it hasn't been saved to your machine, it will first download it.  Then it loads the shard file, printing all of the output.

```
~ markjosef$ shard shard-test/basic
Hello, world!
Hello, yourself!
```

__$ shard *username/shard* fetch__

This downloads the code for the named shard, and saves it in `~/.shard/username/shard/HEAD/`.  This will always fetch a fresh version of the source.

```
~ markjosef$ shard mark/pointer fetch
Saving description.md
Saving pointer.shard.rb
Saving pointer_spec.rb
VERSION 43baf4ee...
```

__$ shard *username/shard* test__

This runs the named shard—but instead of running the *shardname*.shard.rb file, it runs all of the *_test.rb and *_spec.rb files.  (You can control when your shard file gets loaded by manually requiring it via `require_relative`).

```
~ markjosef$ shard test mark/pointer
Run options: --seed 55298

# Running:

.....

Finished in 0.002799s, 1786.3523 runs/s, 1786.3523 assertions/s.

5 runs, 5 assertions, 0 failures, 0 errors, 0 skips
```

__$ shard *username/shard* view__

This will open a new browser window to the shard named.  Right now this is OS X only, but when I figure out how to make it cross-platform, I will.

### Authentication

To use shard features that require being logged in to Github, run:

__$ shard config__

```
~ markjosef$ shard config
To use shard features that require a Github login,
please enter your username and password below.

Note, you can provide an Personal Access Token instead
of a password (recommended).
(See https://github.com/settings/tokens/new for more information)

  Username | mark
  Password | 
Credentials saved to ~/.netrc

The saved Github credentials are valid.
```

I recommend using a person access token instead of your github password.  You can create a new personal access token [here](https://github.com/settings/tokens/new).

If you wish to remove your credentials, just leave username and password blank.

Once you have authenticated, you can view private shards (shards from private gists), as well as the following commands:

__$ shard *username/shard* fork__

Forks the named shard into your own Github account.  If you're not currently logged in, it will prompt you to enter your credentials (as above).

```
~ markjosef$ shard zobar/option fork
Forking zobar/option...
```

### Shards inside your ruby code

Much like the `require` and `gem` commands, you can load a shard file from inside any Ruby code using:

`Kernel#shard(shard_path)`

For example:

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
