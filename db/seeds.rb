# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#
unless Category.all.any?
  categories = ["Deathmatch", "MGE", "BBall", "Mid Air"]
  categories.each do |category|
    Category.find_or_create_by_name(category)
  end
end

unless Location.all.any?
  locations = [
                {:name => "Austria",        :flag => "at"},
                {:name => "Belgium",        :flag => "be"},
                {:name => "Canada",         :flag => "ca"},
                {:name => "Czech Republic", :flag => "cz"},
                {:name => "Denmark",        :flag => "dk"},
                {:name => "England",        :flag => "en"},
                {:name => "EU",             :flag => "europeanunion"},
                {:name => "Germany",        :flag => "de"},
                {:name => "Finland",        :flag => "fi"},
                {:name => "France",         :flag => "fr"},
                {:name => "Hungary",        :flag => "hu"},
                {:name => "Ireland",        :flag => "ie"},
                {:name => "Israel",         :flag => "il"},
                {:name => "Latvia",         :flag => "lt"},
                {:name => "Netherlands",    :flag => "nl"},
                {:name => "Norway",         :flag => "no"},
                {:name => "Russia",         :flag => "ru"},
                {:name => "Scotland",       :flag => "scotland"},
                {:name => "Spain",          :flag => "es"},
                {:name => "UK",             :flag => "uk"}
                {:name => "USA",            :flag => "us"}
              ]
  locations.each do |location|
    Location.find_or_create_by_name(location[:name], :flag => location[:flag])
  end
end
