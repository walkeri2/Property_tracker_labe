require('pry')

require_relative('models/property_tracker.rb')

PropertyTracker.delete_all()

property1 = PropertyTracker.new(
  {'value' => '100000',
    'number_of_bedrooms' => '2',
    'year_built' => '1995',
    'address' => '5 Renfrew'
    }
  )

  property2 = PropertyTracker.new(
    {'value' => '250000',
      'number_of_bedrooms' => '4',
      'year_built' => '1980',
      'address' => '10 Dumbarton'
      }
    )



    property1.save()
    property2.save()

    property1.value = 50

    property1.update()

    found_by_id = PropertyTracker.find_property_by_id(property1.id)

    found_by_address = PropertyTracker.find_property_by_address(property1.address)

binding.pry
nil
