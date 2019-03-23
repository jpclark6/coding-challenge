# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

link_1 = Link.create!(link: 'wolf', slug: 'wolf')
link_2 = Link.create!(link: 'bear', slug: 'bear')
link_3 = Link.create!(link: 'tiger', slug: 'tiger')

Click.create(link: link_1)
Click.create(link: link_1)
Click.create(link: link_2)
Click.create(link: link_3)