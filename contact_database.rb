## TODO: Implement CSV reading/writing
require 'pg'
require 'pry'

class ContactDatabase

  def initialize
    connect
  end

  def list_all
    select_query("SELECT * FROM contacts");
  end

  def find_contact_by_id(id)
    select_query("SELECT * FROM contacts WHERE id = $1",[id])
  end

  def find_contact_by_name_or_email(index)
    select_query("SELECT * FROM contacts WHERE name LIKE '%' || $1 || '%' OR email LIKE '%' || $1 || '%'",[index])
  end

  def create_new_contact(name,email,phone)
    run_query("INSERT INTO contacts (name,email,phone_number) VALUES ($1,$2,$3) RETURNING id",[name,email,phone])
  end

  def delete_contact(id)
    #take passed ID and compare with compare with all records in the data base
    run_query("DELETE FROM contacts WHERE id = $1",[id])
  end
 
  private

  def run_query(query, param)
    @conn.exec_params(query,param)
  end

  def select_query(query,param=nil)
    @conn.exec_params(query,param) do |results|
    # results is a collection (array) of records (hashes)
      results.map do |contacts|
        #puts author.inspect

          id = contacts['id'].to_i
          name = contacts['name']
          email = contacts['email']
          phone = contacts ['phone_number']
          contact = Contact.new(id, name, email, phone)
      end
    end
  end

  def connect
    @conn = PG.connect(
      host: 'localhost',
      dbname: 'contact_list_v2',
      user: 'development',
      password: 'development'
    )
  end

  def closing_connection
    @conn.close
  end

end





