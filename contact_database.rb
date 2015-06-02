## TODO: Implement CSV reading/writing
require 'csv'

class ContactDatabase

  attr_accessor :array_of_contacts, :array_to_find, :new_user_to_add


  @new_user_to_add = []

  def initialize
    
  end

  def load_contacts
    @array_of_contacts = []
    @array_to_find = []

    #loops through list, and insers each row of items into variables
    CSV.foreach('contacts.csv', converters: :numeric) do |row|
      #puts row.inspect
      @array_of_contacts << row
      @array_to_find << row
    end
    return @array_of_contacts
  end

  def find_contact_by_id(id)
    load_contacts
    contact_find = array_to_find.select { |contact| contact[0] == id }
    contact_find = contact_find[0]
    puts contact_find == nil ? "Sorry, ID cannot be found" : "#{contact_find[0]}: #{contact_find[1]}(#{contact_find[2]})"
  end

  def find_contact_by_list_index(index)
    load_contacts
    contact_find = array_of_contacts[index-1]
    puts contact_find == nil ? "Sorry, Index cannot be found" : "#{contact_find[0]}: #{contact_find[1]}(#{contact_find[2]})"
  end

  def list_all
    load_contacts
    puts "Full List of Contacts: "
    @array_of_contacts.each do |x|
      puts "#{x[0]}: #{x[1]}(#{x[2]})"
    end
    puts "---\nTotal of #{@array_of_contacts.length} contacts"

  end

  def create_new_contact(name, email)
    load_contacts
    #figures out the next ID
    next_id_to_append = @array_of_contacts.last[0].to_i + 1
    @new_user_to_add = [next_id_to_append, name, email]
    contact_info_validation
  end

  def contact_info_validation
    if @array_of_contacts.any?{|email| email[2].include? @new_user_to_add[2] }
      puts "sorry, this email has been used"
    else
    @array_of_contacts << @new_user_to_add
    save_contact
    puts "#{new_user_to_add[0]}: #{new_user_to_add[1]}(#{new_user_to_add[2]}) has been successfully saved"
    end
  end

  def save_contact
    #Appends to the file
    #enters, and information is passed on to the database
    CSV.open('contacts.csv', 'w') do |csv_object|
      @array_of_contacts.each do |row_array|
        csv_object << row_array
      end
    end

  end

end






