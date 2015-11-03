require 'squib'

# TODO Get these helper methods into other helper methods later, maybe even into Squib proper
def sample(str)
  @sample_x ||= 100
  @sample_y ||= 100
  rect x: 460, y: @sample_y - 40, width: 600,
       height: 180, fill_color: '#FFD655', stroke_color: 'black', radius: 15
  text str: str, x: 460, y: @sample_y - 40,
       width: 540, height: 180,
       valign: 'middle', align: 'center',
       font: 'Times New Roman,Serif 24'
  yield @sample_x, @sample_y
  @sample_y += 200
end

def draw_graph_paper(width, height)
  background color: 'white'
  grid width: 50,  height: 50,  stroke_color: '#0066FF', stroke_width: 1.5
  grid width: 200, height: 200, stroke_color: '#0066FF', stroke_width: 3, x: 50, y: 50
  (50..height).step(200) do |y|
    text str: "y=#{y}", x: 3, y: y - 18, font: 'Open Sans, Sans 10'
  end
end

Squib::Deck.new(width: 1000, height: 3000) do
  draw_graph_paper width, height

  sample "This a PNG.\nNo scaling is done by default." do |x, y|
    png file: 'shiny-purse.png', x: x, y: y
  end

  sample 'PNGs can be upscaled, but they will emit an antialias warning (unless you turn it off in the config.yml)' do |x,y|
    png file: 'shiny-purse.png', x: x, y: y, width: 150, height: 150
  end

  sample 'SVGs can be loaded from a file (left) or from straight XML (right). They can also be scaled to any size.' do |x,y|
    svg file: 'robot-golem.svg', x: x, y: y, width: 100, height: 100
    svg data: File.read('robot-golem.svg'), width: 100, height: 100,
        x: x + 200, y: y
  end

  sample 'PNG and SVG can be auto-scaled by one side and setting the other to :scale' do |x,y|
    svg file: 'spanner.svg', x: x,      y: y, width: 50,     height: :scale
    svg file: 'spanner.svg', x: x + 50, y: y, width: :scale, height: 50

    png file: 'shiny-purse.png', x: x,      y: y + 50, width: 50,     height: :scale
    png file: 'shiny-purse.png', x: x + 50, y: y + 50, width: :scale, height: 50
  end

  sample 'PNGs can be cropped. To work from sprite sheets, you can set crop coordinates to PNG images. Rounded corners supported too.' do |x,y|
    png file: 'sprites.png', x: x - 50, y: y - 50     # entire sprite sheet
    rect x: x - 50, y: y - 50, width: 65, height: 65, # highlight the crop
         radius: 10, dash: '3 3', stroke_color: 'red', stroke_width: 3
    text str: '➜', font: 'Sans Bold 36', x: x + 90, y: y - 50
    png file: 'sprites.png', x: x + 150, y: y - 50,        # just the robot golem image
        crop_x: 0, crop_y: 0, crop_corner_radius: 10,
        crop_width: 64, crop_height: 64

    png file: 'sprites.png', x: x - 50, y: y + 50     # entire sprite sheet again
    rect x: x + 14, y: y + 50, width: 65, height: 65, # highlight the crop
         radius: 25, dash: '3 3', stroke_color: 'red', stroke_width: 3
    text str: '➜', font: 'Sans Bold 36', x: x + 90, y: y + 50
    png file: 'sprites.png', x: x + 170, y: y + 50, # just the drakkar ship image, rotated
        crop_x: 64, crop_y: 0, crop_corner_x_radius: 25, crop_corner_y_radius: 25,
        crop_width: 64, crop_height: 64, angle: Math::PI / 6
  end

  sample 'SVGs can be cropped too.' do |x,y|
    svg file: 'robot-golem.svg', x: x, y: y, width: 100, height: 100,
        crop_x: 40, crop_y: 0, crop_width: 50, crop_height: 50
  end

  sample 'Images can be flipped about their center.' do |x,y|
    png file: 'shiny-purse.png', x: x, y: y, flip_vertical: true, flip_horizontal: true
    svg file: 'robot-golem.svg', x: x + 200, y: y, width: 100, height: 100,
        flip_horizontal: true
  end

  sample 'SVG can be limited to rendering to a single object if the SVG ID is set. If you look at this SVG file, the black backdrop has ID #backdrop.' do |x,y|
    svg file: 'spanner.svg', id: 'backdrop', x: x, y: y, width: 100, height: 100
  end

  sample "The SVG force_id option allows use of an ID only when specified, and render nothing if empty. Useful for multiple icons in one SVG file.\nThis should show nothing." do |x,y|
    svg file: 'spanner.svg', x: x, y: y,
        force_id: true, id: '' # <-- the important parts
  end

  sample 'NOTE! If you render a single object in an SVG, its placement is still relative to the SVG document.' do |x,y|
    svg file: 'offset.svg', x: x, y: y
    rect x: x, y: y, width: 100, height: 100, dash: '3 1', stroke_color: 'red', stroke_width: 3

    svg file: 'offset.svg', id: 'thing',  x: x + 200, y: y, width: 100, height: 100
    rect x: x + 200, y: y, width: 100, height: 100, dash: '3 1', stroke_color: 'red', stroke_width: 3
  end


  sample 'PNGs can be blended onto each other with 15 different blending operators. Alpha transparency supported too. See http://cairographics.org/operators' do |x,y|
    png file: 'ball.png', x: x,      y: y
    png file: 'grit.png', x: x + 20, y: y + 20, blend: :color_burn, alpha: 0.75
  end

  sample 'Rotation is around the upper-left corner of the image. Unit is radians.' do |x,y|
    rect x: x, y: y, width: 100, height: 100, stroke_width: 3, dash: '3 3', stroke_color: :red
    png  x: x,  y: y, width: 100, height: 100, angle: Math::PI / 4, file: 'shiny-purse.png'

    rect x: x + 250, y: y, width: 100, height: 100, stroke_width: 3, dash: '3 3', stroke_color: :red
    svg  x: x + 250, y: y, width: 100, height: 100, file: 'robot-golem.svg',
        angle: Math::PI / 2 - 0.2
  end

  sample 'SVGs and PNGs can be used as masks for colors instead of being directly rendered.' do |x,y|
    svg mask: '#00ff00', file: 'glass-heart.svg', x: x - 50, y: y - 50, width: 200, height: 200
    svg mask: '(0,0)(0,500) #ccc@0.0 #333@1.0', file: 'glass-heart.svg', x: x + 150, y: y - 50, width: 200, height: 200
  end

  sample 'PNG masks are based on the alpha channel, so this is just a magenta square with rounded corners.' do |x,y|
    png file: 'shiny-purse.png', mask: :magenta, x: x, y: y
  end

  save_png prefix: 'load_image_sheet_'
end
