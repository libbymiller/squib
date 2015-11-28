require 'squib'

Squib::Deck.new(width: 825, height: 1125, cards: 50) do
  background color: :white
  data = xlsx file: 'emoj.xlsx'
  
  new_emoj = []
  new_names = []

  count = 0
  data['Use'].each do |u|

   if(u=="1" && data['Name'][count] && data['Name'][count]!="")
     e = data['Code'][count]
     e = e.gsub(/U\+/,"")
     e = "emoji-svg/#{e.downcase}.svg"
     new_emoj.push(e)
     new_names.push(data['Name'][count])
   end
   count = count + 1
  end

#  pp new_names
#  pp new_emoj

  text str: new_names,
       color: '#BEBBBF', font: 'Helvetica,Sans 72',
       y: '3in', width: '2.75in', align: :center, ellipsize: true

  svg file: new_emoj,
      width: 500, height: 500,
      x: 150, y: 250 

  save prefix: 'emoji_', format: :png
  save_pdf file: 'emoji.pdf'
end
