r1 = Room.find_or_initialize_by_name('Home')
r1.description = "This is a lovely little house that you own. It's not perfect, but it's yours."
r1.save!

r2 = Room.find_or_initialize_by_name 'Bathroom'
r2.description = "This is where you deposit your waste."
r2.southwest = r1
r2.save!

r1.northeast = r2
r1.save!

c = Character.find_or_initialize_by_name_and_player("Rob", true)
c.room = r1
c.save!

c2 = Character.find_or_initialize_by_name("Becky")
c2.room = r2
c2.save!

i1 = r1.items.create!({:name => 'Toothbrush'})