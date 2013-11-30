# Meem

Meem is a command-line tool to create memes. It's pretty awesome.

### Usage

    $ meem good-guy-greg --top "makes memes" --bottom "saves to disk"
    /tmp/meme.jpg

    $ meem good-guy-greg --top "makes memes" --bottom "uploads to imgur" | imgur
    http://i.imgur.com/VBCRwlb.jpg

Meem comes with a bunch of templates, but you can add your own in `~/.meem`. If you don't want to save
it for later, you can even pass a path or URL.

### Installation

    $ gem install meem
