DIRECTORY = File.expand_path File.dirname __FILE__

require "meem/version"
require "meem/templates"
require "optparse"
require "ostruct"
require "meme_captain"

module Meem
  def self.run arguments
    options = parse arguments

    template = Templates.load options.meme

    if template
      image = generate template, options.top, options.bottom

      if STDOUT.tty?
        path = "/tmp/meme.jpg"

        image.write path
        puts path
      else
        puts image.to_blob
      end
    else
      error "meme not found"
    end
  end

  # Parse options.
  #
  # arguments - An Array of arguments.
  #
  # Returns options.
  def self.parse arguments
    arguments = ["--help"] if arguments.empty?

    options      = OpenStruct.new
    options.meme = arguments.first

    OptionParser.new do |opts|
      opts.program_name = "meem"
      opts.banner = "usage: meem <meme> [options]"
      opts.version = Meem::VERSION

      opts.on "-l", "--list", "List memes" do
        Templates.list.each do |file|
          puts file.basename.to_s[/(.*)\.jpg/, 1]
        end

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

  private

  # Generate a meme.
  # 
  # template - A File describing a template.
  # top      - A String describing the top caption.
  # bottom   - A String describing the bottom caption.
  def self.generate template, top, bottom
    MemeCaptain.meme_top_bottom template, top, bottom, font: "#{DIRECTORY}/../fonts/impact.ttf"
  end

  # Print a message and exit.
  #
  # message - A String describing the message.
  # code    - An Integer describing the error code.
  def self.error message, code = 1
    puts "meem: #{message}"
    exit code
  end
end
