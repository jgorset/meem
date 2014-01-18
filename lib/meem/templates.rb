require "pathname"
require "open-uri"

module Meem::Templates
  PATHS = [
    Pathname.new("#{ENV['HOME']}/.meem/"),
    Pathname.new("#{DIRECTORY}/../templates/")
  ]

  # List templates.
  #
  # Returns an Array of Pathname instances.
  def self.list
    PATHS.map do |path|
      next unless File.exists?(path)
      path.children.select { |child| child.extname == ".jpg" }
    end.compact.flatten
  end

  # Find a given template.
  #
  # template - A String describing a template.
  #
  # Return a Pathname instance.
  def self.find template
    list.find { |file| file.basename.to_s =~ /#{template}/ }
  end

  # Load a template from file or the internet.
  #
  # template - A String describing a template.
  #
  # Returns a File.
  def self.load template
    if template[/(^https?:\/\/)|(\/)/]
      return open template
    else
      find template
    end
  end
end
