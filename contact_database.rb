## TODO: Implement CSV reading/writing
require 'pg'
require 'pry'

class ContactDatabase

  def initialize
    connect
  end

  def email_exist(email)
    select_query("SELECT email from contacts WHERE email = $1",[email])
  end

  def list_all
    select_query("SELECT * FROM contacts");
  end

  def find_contact_by_id(id)
    select_query("SELECT * FROM contacts WHERE id = $1",[id])[0]
  end

  def find_contact_by_name_or_email(index)
    select_query("SELECT * FROM contacts WHERE name LIKE '%' || $1 || '%' OR email LIKE '%' || $1 || '%'",[index])
  end

  def create_new_contact(name,email,phone)
    run_query("INSERT INTO contacts (name,email,phone_number) VALUES ($1,$2,$3) RETURNING id",[name,email,phone])
  end

  def contact_update(id,name,email,phone)
    run_query("UPDATE contacts SET name = $1, email = $2, phone_number = $3 WHERE id = $4",[name,email,phone,id])
  end 

  def delete_contact(id)
    run_query("DELETE FROM contacts WHERE id = $1",[id])
  end
 
  private

  def run_query(query, param)
    @conn.exec_params(query,param)
  end

  def select_query(query,param=nil)
    results = []
    @conn.exec_params(query,param) do |rows|
    # results is a collection (array) of records (hashes)
      rows.each do |contact|
        #puts author.inspect

          id = contact['id'].to_i
          name = contact['name']
          email = contact['email']
          phone = contact ['phone_number']
          contact = Contact.new(id, name, email, phone)
          results << contact
      end
    end
    results
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





