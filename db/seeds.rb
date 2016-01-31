# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
  User.create(name: 'Emanuel', password: 'Emanuel')
  User.create(name: 'kate', password: 'kate')
  User.create(name: 'dan', password: 'dan')
  User.create(name: 'bob', password: 'bob')
