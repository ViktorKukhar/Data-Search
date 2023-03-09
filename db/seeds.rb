json_data = File.read(Rails.root.join('db', 'data.json'))
data = JSON.parse(json_data)

data.each do |data|
  item = Item.new(
    name: data['Name'],
    category: data['Type'],
    designed_by: data['Designed by']
  )
  item.save
end
