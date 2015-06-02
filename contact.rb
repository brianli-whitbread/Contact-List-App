require_relative 'contact_database'

class Contact
 
  attr_accessor :name, :email

  @database = ContactDatabase.new

  def initialize(name, email)
    # TODO: assign local variables to instance variables
    @name = name
    @email = email
  end
 
  def to_s
    # TODO: return string representation of Contact
    puts "#{name} (#{email}"
  end
 
  ## Class Methods
  class << self
    def create(name, email)
      # TODO: Will initialize a contact as well as add it to the list of contacts
      #@database.get_contacts
      @database.create_new_contact(name,email)
      @database.save_contact
    end
 
    def find(index)
      # TODO: Will find and return contact by index
      @database.find_contact_by_list_index(index.to_i)
    end
 
    def all
      # TODO: Return the list of contacts, as is
       @database.list_all
    end
    
    def show(id)
      # TODO: Show a contact, based on ID
      @database.find_contact_by_id(id.to_i)
    end
    
  end
 
end

