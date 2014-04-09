# Meem

Meem is a command-line tool to create memes. It's pretty awesome.

## Usage

    $ meem good-guy-greg --top "makes memes" --bottom "saves to disk"
    /tmp/meme.jpg

    $ meem good-guy-greg --top "makes memes" --bottom "uploads to imgur" | imgur
    http://i.imgur.com/VBCRwlb.jpg

Meem ships with a bunch of templates, and you can add your own in `~/.meem`. If you don't want to save
it for later, you can even pass a path or URL.

## Completion

Meem comes with autocompletion for your favorite shell (as long as your favorite shell is zsh). To install it,
copy `completion/meem.zsh` onto your `$FPATH`.

## Installation

    $ gem install meem

## I love you

Johannes Gorset made this. You should [tweet me](https://twitter.com/jgorset) if you can't get it to
work. In fact, you should tweet me anyway.
