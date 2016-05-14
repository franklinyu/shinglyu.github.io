---
layout: post
title:  "Rust Code Completion with YouCompleteMe"
categories: Productivity
date:   2016-04-06 21:55:00 +08:00
excerpt_separator: <!--more-->
---

Every programmer knows that code completion can give you a productivity boost. Without code completion, you'll have to read the documentation (or StackOverflow?) every time you forget what to type next. Since I'm a vim user and I worked with [Rust]() very often, I'm glad to know [YouCompleteMe]() (YCM), a powerful code completion plug-in for vim, officially supports Rust code completion (see this [blog post](http://blog.jwilm.io/youcompleteme-rust/)). 


## Prerequisite
I'll walk you through the process of installing YCM on Ubuntu/Linux Mint. You'll need:

* vim (obviously!)
* git (Vundle needs it)
* latest stable `rustc` and `cargo` (YCM needs to compile the `racerd` completion server, follow this [installation guide]())
* Python 2 
* Install the required packages for YCM: `sudo apt-get install build-essential cmake python-dev python3-dev`

If you use other OS, you can find the installation guide [here](https://github.com/Valloric/YouCompleteMe#installation).

## Installation

First, we'll install YouCompleteMe through Vundle. YCM is not a simple vimscript or python based vim plug-in, there are compiled components so you'll have to compile it when you first install it, and re-compile it every time you update. [Vundle]() is a package manager for vim; It allows you to specify the plug-ins you want in your `.vimrc` file and it will handle the install/uninstall for you. Vundle can be installed easily by following the official [quick start guide](https://github.com/VundleVim/Vundle.vim#quick-start).

After you installed Vundle, you can add the following line to your `~/.vimrc`:

~~~
Plugin 'Valloric/YouCompleteMe'
~~~

Then run `:PluginInstall` in vim (in normal mode). Vundle should download and install YCM into the `~/.vim/bundle/YouCompleteMe` folder. YCM is quite big in size, so if the `:PluginInstall` step may takes a long time based on your network connection, be patient and wait for it to finish.  If you already have an old version of YCM installed, you can run `:PluginUpdate` instead.

Now, let's compile YCM and include the Rust support:

~~~
cd ~/.vim/bundle/YouCompleteMe
./install.py --racer-completer
~~~

The `install.py` commmand It will take some time to compile. The `--racer-completer` argument tells the YCM installer to download `racerd` via [Cargo]() and compile it for you.

If you ever wonder why it's called `--racer-completer`, it's because YCM relies on [`racerd`](https://github.com/jwilm/racerd) for Rust semantic completion. `racerd` is a JSON/HTTP server powered by [`racer`](), a Rust code completion tool. (You can install `racer` directly and use it with vim plugins like [`vim-racer`](), but it's not as convenient as YCM.) When you type your Rust code in vim, YCM will communicate with the `racerd` to get the code completion suggestions.


For the Rust completer to work, you'll also need a local copy of the Rust source code. You can `git clone` the Rust source code from [GitHub]() or [download the tarball](). Choose the version you'll be writing Rust code in. Then you'll need to point to the source code in your `~/.vimrc` like so:

~~~
" In this example, the rust source code zip has been extracted to
" /usr/local/rust/rustc-1.8.0
let g:ycm_rust_src_path = '/usr/local/rust/rustc-1.8.0/src'
~~~

Now we are all set! Next time you opened a Rust file, YCM will start to work.

## Usage

YCM automatically kicks in when  you type `::` or `.`. Here are some example:


It can also help you "jump" to the definition of a variable, function, struct, etc. Simply locate your cursor on anything (in normal mode) and run `:YcmCompleter GoTo` to jump.

You can map the verbose command to some hotkey, for example `\]` (backslash followed by right square bracket),  add the following line to your `~/.vimrc`:

~~~
nnoremap <Leader>] :YcmCompleter GoTo<CR>
~~~


