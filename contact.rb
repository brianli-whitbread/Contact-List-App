require_relative 'contact_database'

class Contact 
 
  attr_accessor :id, :name, :email, :phone

  @database = ContactDatabase.new

  def initialize(id, name, email, phone)
    # TODO: assign local variables to instance variables
    @id = id
    @name = name
    @email = email
    @phone = phone
  end
 
  def to_s
    # TODO: return string representation of Contact
    puts "#{name} (#{email}"
  end

  def save
    if id == nil
      self.class.create(name,email,phone)
    else
      self.class.update(id,name,email,phone)
    end
    #using id to check if [id] exist
    #if [id] exist, then just UPDATE the contact
    #if [id[ doesn't exist, INSERT a new contact
  end

  def destroy
    self.class.delete_contact(id)
  end
 
  ## Class Methods
  class << self

    def email_exist(email)
      #checks the database to see if the email exist
      @database.email_exist(email)
    end

    def create(name, email, phone)
      # TODO: Will initialize a contact as well as add it to the list of contacts
      @database.create_new_contact(name,email,phone)
    end

    def update(id,name,email,phone)
      @database.contact_update(id,name,email,phone)
    end
 
    def find(index)
      # TODO: Will find and return contact by index
      @database.find_contact_by_name_or_email(index)
    end
 
    def all
      # TODO: Return the list of contacts, as is
       @database.list_all
    end
    
    def show(id)
      # TODO: Show a contact, based on ID
      @database.find_contact_by_id(id.to_i)
    end

    def delete_contact(id)
      @database.delete_contact(id)
    end

  end
 
end

