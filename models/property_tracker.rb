require('pg')
# require('pry')

class PropertyTracker

  attr_accessor :value, :number_of_bedrooms, :year_built, :address
  attr_reader :id

  def initialize(options)
    @value = options['value'].to_i
    @number_of_bedrooms = options['number_of_bedrooms'].to_i
    @year_built = options['year_built'].to_i
    @address = options['address']
    @id = options['id'].to_i if options['id']
  end

  def PropertyTracker.all()
    db = PG.connect({dbname: 'property_tracker', host: 'localhost'})
    sql = "SELECT * FROM property_tracker"
    db.prepare("all", sql)
    property = db.exec_prepared("all")
    db.close
    return property.map{|property| PropertyTracker.new(property)}
  end

  def save()
    db = PG.connect({dbname: 'property_tracker', host: 'localhost'})
    sql = "INSERT INTO property_tracker
          (value, number_of_bedrooms, year_built, address)
          VALUES($1, $2, $3, $4) RETURNING *"
    values = [@value, @number_of_bedrooms, @year_built, @address]
    db.prepare("save", sql)
    @id = db.exec_prepared("save", values)[0]["id"].to_i
    db.close()
  end

  def update()
    db = PG.connect({dbname: 'property_tracker', host: 'localhost'})
    sql = "UPDATE property_tracker SET (value, number_of_bedrooms, year_built, address) = ($1, $2, $3, $4) WHERE id = $5"
    values = [@value, @number_of_bedrooms, @year_built, @address, @id]
    db.prepare("update", sql)
    db.exec_prepared("update", values)
    db.close()
  end

  def PropertyTracker.delete_all()
    db = PG.connect({dbname: 'property_tracker', host: 'localhost'})
    sql = "DELETE FROM property_tracker;"
    db.prepare("delete_all", sql)
    db.exec_prepared("delete_all")
    db.close()
  end

  def PropertyTracker.find_property_by_id(id)
    db = PG.connect({dbname: 'property_tracker', host: 'localhost'})
    sql = "SELECT * FROM property_tracker WHERE id = $1"
    values = [id]
    db.prepare("find_property_by_id", sql)
    output = db.exec_prepared("find_property_by_id", values)
    db.close()
    return PropertyTracker.new(output.first)
  end

    def PropertyTracker.find_property_by_address(address)
      db = PG.connect({dbname: 'property_tracker', host: 'localhost'})
      sql = "SELECT * FROM property_tracker WHERE address = $1"
      values = [address]
      db.prepare("find_property_by_address", sql)
      output = db.exec_prepared("find_property_by_address", values)
      db.close()
      return PropertyTracker.new(output.first)
    end









  # SELECT * FROM property_tracker WHERE address = '5 Renfrew'
end
