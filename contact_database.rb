## TODO: Implement CSV reading/writing
require 'csv'

class ContactDatabase

  attr_accessor :array_of_contacts, :new_user_to_add

  def load_contacts
    @new_user_to_add = []
    @array_of_contacts = []

    #loops through list, and insers each row of items into variables
    CSV.foreach('contacts.csv', converters: :numeric) do |row|
      #puts row.inspect
      id = row[0]
      name = row[1]
      email = row[2]
      phone = row [3]
      contact = Contact.new(id, name, email, phone)
      @array_of_contacts << contact


    end
    return @array_of_contacts
  end

  def find_contact_by_id(id)
    load_contacts
    contact = @array_of_contacts.detect {|contact| contact.id == id}
    puts contact == nil ? "Sorry, contact cannot be found" : "#{contact.id}: #{contact.name}(#{contact.email}) - Phone: #{contact.phone}"
  end

  # FIXME: the search capabilities is not strong enough
  def find_contact_by_list_index(index)
    load_contacts
    if index.empty?
      puts "Sorry, Index cannot be found"
    elsif index.match /.*\.com$/
      contact_find = @array_of_contacts.select { |contact| contact.email.match index }
      #if multiple results, then do this
      if contact_find.length > 1
        contact_find.each do |contact|
          puts "#{contact.id}: #{contact.name}(#{contact.email}) - Phone: #{contact.phone}"
        end
      else
        contact = contact_find[0]
        puts "#{contact.id}: #{contact.name}(#{contact.email}) - Phone: #{contact.phone}"
      end
    else
      contact_find = @array_of_contacts.select { |contact| contact.name.match index }

      if contact_find.length > 1
        contact_find.each do |contact|
          puts "#{contact.id}: #{contact.name}(#{contact.email}) - Phone: #{contact.phone}"
        end
      else
        contact_find = contact_find[0]
        puts contact_find == nil ? "Sorry, contact cannot be found" : "#{contact_find.id}: #{contact_find.name}(#{contact_find.email})"
      end

    end
  end

  def list_all
    load_contacts
    puts "Full List of Contacts: "
    @array_of_contacts.each do |contact|
      puts "#{contact.id}: #{contact.name}(#{contact.email}) - Phone: #{contact.phone}"
    end
    puts "---\nTotal of #{@array_of_contacts.length} contacts"

  end

  def create_new_contact(name, email, phone)
    load_contacts
    #figures out the next ID
    next_id_to_append = @array_of_contacts.length + 1
    @new_user_to_add = Contact.new(next_id_to_append, name, email, phone)
    contact_info_validation
  end

  def contact_info_validation
    if @array_of_contacts.any?{|contact| contact.email.include? @new_user_to_add.name }
      puts "sorry, this email has been used OR the email is not valid"
    else
    @array_of_contacts << @new_user_to_add
    save_contact
    puts "#{new_user_to_add.id}: #{new_user_to_add.name}(#{new_user_to_add.email}) has been successfully saved"
    end
  end

  def save_contact
    # Appends to the file
    # enters, and information is passed on to the database
    CSV.open('contacts.csv', 'w') do |csv_object|
      @array_of_contacts.each do |contact|
        csv_object << [contact.id, contact.name, contact.email, contact.phone]
      end
    end
  end

end





