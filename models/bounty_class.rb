require('pg')
class Bounty
  attr_accessor :name, :species, :bounty_value, :last_known_location
  attr_reader :id
  def initialize (options)
    @name = options['name']
    @species = options['species']
    @bounty_value = options['bounty_value']
    @last_known_location = options['last_known_location']
  end

  def save()
    db = PG.connect( {dbname: 'space_cowboys',
                      host: 'localhost'})
    sql = "INSERT INTO space_cowboys
          (
            name,
            species,
            bounty_value,
            last_known_location
          )
          VALUES ($1, $2, $3, $4)
          RETURNING id
         "
    
    values = [@name, @species, @bounty_value, @last_known_location]
    db.prepare("save", sql)
    @id = db.exec_prepared("save", values)[0]["id"].to_i
    db.close()
  end



  def Bounty.all()
    db = PG.connect( {dbname: 'space_cowboys',
                      host: 'localhost'
                      })
    sql = "SELECT * FROM space_cowboys"
    db.prepare("all", sql)
    wanted = db.exec_prepared("all", sql)
    db.close()
    return wanted.map { |wanted| Bounty.new(wanted) }
  end



  def Bounty.delete_all()
    db = PG.connect( {dbname: 'space_cowboys',
                      host: 'localhost'
                      })
    sql = "DELETE FROM space_cowboys"
    db.prepare("delete_all", sql)
    db.exec_prepared("delete_all")
    db.close
  end


  def update()
    db = PG.connect( {dbname: 'space_cowboys',
                      host: 'localhost'
                      })
    sql = "UPDATE space_cowboys
                    SET (
                    name,
                    species,
                    bounty_value,
                    last_known_location) =
                    ($1, $2, $3, $4)
                    WHERE id = $5;
                    "
    values = [@name, @species, @bounty_value, @last_known_location, @id]
    db.prepare("update", sql)
    db.exec_prepared("update", values)
    db.close()

    end

    def delete()
      db = PG.connect( { dbname: 'space_cowboys',
                         host: 'localhost'
                         })
      sql = "DELETE FROM space_cowboys WHERE id = $1"
      values = [@id]
      db.prepare("delete_one", sql)
      db.exec_prepared("delete_one", values)
      db.close()
    end

    # def find_by_name(name)
    #   db = PG.connect( { dbname: 'space_cowboys',
    #                      host: 'localhost'
    #                      })
    #   sql = "SELECT * FROM space_cowboys WHERE name = $1"
    #   values = [@id]
    #   db.prepare("find_by_name", sql)
    #   db.exec_prepared("find_by_namee", values)
    #   found_bounty = db.exec_prepared("find_by_name", values)
    #   return found_bounty
    #   db.close()
    # end
end
