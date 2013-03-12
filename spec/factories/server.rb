FactoryGirl.define do

  factory :server do
    name "TF2 1"
    host_and_port "fakkelbrigade.eu:27015"
    association :location
    categories [ FactoryGirl.create(:category) ]
  end
end
