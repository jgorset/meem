require "meem/version"
require "optparse"
require "ostruct"
require "meme_captain"
require "open-uri"
require "pathname"

DIRECTORY = File.expand_path File.dirname __FILE__

module Meem
  PATHS = [
    "#{ENV['HOME']}/.meem/",
    "#{DIRECTORY}/../templates/"
  ]

  def self.run arguments
    options = parse arguments

    image = MemeCaptain.meme_top_bottom fetch(options.meme), options.top, options.bottom,
      font: "#{DIRECTORY}/../fonts/impact.ttf"

    if STDOUT.tty?
      path = "/tmp/meme.jpg"

      image.write path
      puts path
    else
      puts image.to_blob
    end
  end

  # Parse options.
  #
  # arguments - An Array of arguments.
  #
  # Returns options.
  def self.parse arguments
    options = OpenStruct.new

    options.meme = arguments.first

    OptionParser.new do |opts|
      opts.program_name = "meem"
      opts.banner = "usage: meem <meme> <top text> <bottom text>"
      opts.version = Meem::VERSION

      opts.on "-l", "--list", "List memes" do
        list
        exit
      end

      opts.on "-t", "--top TEXT", "Set top text" do |value|
        options.top = value
      end

      opts.on "-b", "--bottom TEXT", "Set bottom text" do |value|
        options.bottom = value
      end
      
      opts.on "-h", "--help", "Show this message" do
        puts opts
        exit
      end

      opts.on "-v", "--version", "Show version" do
        puts Meem::VERSION
        exit
      end
    end.parse! arguments

    options
  end

  # List memes.
  def self.list
    PATHS.each do |path|
      Dir.glob "#{path}/*.jpg" do |file|
        file = Pathname.new file

        puts "* " + file.basename.to_s[/(.*)\.jpg/, 1]
      end
    end
  end

  private

  # Print a message and exit.
  #
  # message - A String describing the message.
  # code    - An Integer describing the error code.
  def self.error message, code = 1
    puts "meem: #{message}"
    exit code
  end

  # Load a meme.
  #
  # meme - A String describing a meme.
  #
  # Returns a File.
  def self.fetch meme
    if meme[/^http:\/\//]
      return open meme
    else
      PATHS.each do |path|
        image = path + "#{meme}.jpg"

        if File.exists? image
          return open image
        end
      end

      error "meme not found"
    end
  end
end
