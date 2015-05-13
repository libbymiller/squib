require 'squib'
require 'nokogiri'
require 'yaml'

# This sample demonstrates how you can parse SVGs to get your xy coordinates
# as a way to create wireframes of your card visually.
#
# We don't really leverage any special features from Squib, just a technique
# that uses Nokogiri (which is already included with Squib) for XML parsing.
#
# The referenced file, wireframe.svg, was created with Inkscape 0.91. as a
# "plain SVG". It uses pixels as its coordinate system and has IDs set for the
# rectangles. The SVG also has lots of other text to help remember what each
# thing is, but those are not parsed.Note that Inkscape's SVG uses an inverted
# y-coordinate, so that can be rather annoying for us.
#
# We then parse the SVG and load coordinates into a Yaml file. This then gets
# merged with our own styles (wireframe-styles.yml), such as font and centering.

# def load_wireframe(svgids)
#   xml    = Nokogiri::XML(File.read('wireframe.svg'))
#   layout = Hash.new
#   Array(svgids).each do |svgid|
#     layout[svgid] ||= Hash.new
#     attributes = xml.xpath("//svg:rect[@id=\"#{svgid}\"]").first.attributes
#     %w(x y width height).each do |coord|
#       layout[svgid][coord] = attributes[coord].value.to_f
#     end
#   end
#   File.open('wireframe.yml', 'w+') { |f| f.write(layout.to_yaml) }
# end

# load_wireframe(%w(border title art description))
require 'pp'
Squib::Deck.new(cards: 1, layout: ['wireframe.yml', 'wireframe-styles.yml']) do
  background color: '#ddd'
  rect layout: :border
  pp layout
  text str: 'The Title', layout: :title
  text str: 'The Art', layout: :art
  text str: 'The Description', layout: :description#, hint: :red
  save_png prefix: 'wireframe_'
end