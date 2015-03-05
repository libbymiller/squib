require 'squib'

def draw_score(x, y, i, angle)
  rect x: x, y: y, width: 50, height: 50, radius: 15
  case angle
  when Math::PI / 2
    x += 50
  when Math::PI
    y += 50
  end
  text x: x, y: y, width: 50, height: 50,
       align: :center, valign: :middle,
       str: i, font: 'Sans Bold 24', angle: angle
end

Squib::Deck.new do
  background color: '#ccc'

  size     = 50
  margin   = 5
  gap      = 3

  x        = margin
  y        = margin
  angle    = 0
  path = [:east, :south, :west, :north]
  path_idx = 0
  side_idx = 0
  0.upto(100) do |i|
    case path[path_idx]
    when :east
      x = side_idx * (size + gap) + margin
      y = margin
      side_idx += 1
      if side_idx >= (@width - 2 * margin) / (size + gap)
        path_idx += 1
        side_idx = 1 # don't overlap
      end
    when :south
      angle = Math::PI / 2
      x = @width - margin - size
      y = side_idx * (size + gap) + margin
      side_idx += 1
      if side_idx >= (@height - 2 * margin) / (size + gap)
        path_idx += 1
        side_idx = 1 # don't overlap
      end
    when :west
      angle = Math::PI
      x = @width - side_idx * (size + gap) + margin
      y = @height - margin - size
      side_idx += 1
      if side_idx >= (@width - 2 * margin) / (size + gap)
        path_idx += 1
        side_idx = 1 # don't overlap
      end
    else
      x = -100
      y = -100
    end
    draw_score(x, y, i, angle)
  end
  save_png prefix: 'scoring_'

end