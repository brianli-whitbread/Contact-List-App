require_relative 'contact'
require_relative 'contact_database'

def help_menu
  print "\n\nHere is a list of available commands:\n
    new  - Create a new contact\n
    upate  - Create a new contact\n
    list - List all Contacts\n
    show - Show a Contact by ID\n
    find - Find by Contact Name or Contact Email\n\n > "
    execute(STDIN.gets.chomp)
end

def set_phone
  phone_numbers = ''

  adding_phone_numbers = true

  while adding_phone_numbers
    phone_numbers << "; " unless phone_numbers.empty?
    puts "Label for the Phone Number"
    print "> "
    phone_numbers << STDIN.gets.chomp + ":"
    puts "Phone Number"
    print "> "
    phone_numbers << " " + STDIN.gets.chomp
    puts "add another number? (yes/no)"
    if STDIN.gets.chomp == "yes"
    else
      adding_phone_numbers = false;
    end
  end
  return phone_numbers
end

def set_email
  ask_for_email = true
  while ask_for_email
    print "Email: "
    email = STDIN.gets.chomp.downcase
    unless email.match /.*\@.*$/
      puts "Sorry, your email is not in the correct format"
    else
      if (Contact.email_exist(email)).empty?
        return email
        ask_for_email = false
      else
        puts "Your email is already used. Please input another email address"
      end
    end
  end
end

def new_contact
  puts "Add New Contact"
  print "Name: "
  name = STDIN.gets.chomp
  email = set_email
  phone = set_phone
  contact = Contact.new(nil, name, email, phone)
  contact.save
  puts "New Contact Created: #{name}, #{email}, #{phone}"
end



def update_contact
  Contact.all.each do |contact|
    puts "#{contact.id}: #{contact.name}(#{contact.email}) - Phone: #{contact.phone}"
  end
  puts "\n\nWhich contact would you like to update?"
  print "id: "
  contact = Contact.show(STDIN.gets.chomp)
  print "You must fill in every field!\n--------------------------\n"
  print "Full Name: "
  contact.name = STDIN.gets.chomp
  contact.email = set_email
  contact.phone = set_phone
  contact.save
  puts "#{contact.id}: #{contact.name}(#{contact.email}) - Phone: #{contact.phone} has been UPDATED!" 
end

def list_all_contact
  puts "List all contacts"
  Contact.all.each do |contact|
    puts "#{contact.id}: #{contact.name}(#{contact.email}) - Phone: #{contact.phone}"
  end

end

def show_a_contact(id=nil)
  puts "Show a Contact"
  unless id==nil
    contacts = Contact.show(id)
  else
    print "id: "
    contacts = Contact.show(STDIN.gets.chomp)
  end
  contacts.each do |contact|
    puts "#{contact.id}: #{contact.name}(#{contact.email}) - Phone: #{contact.phone}"
  end
end

def find_a_contact(string=nil)
  puts "Find by Contact Name or Contact Email"
  unless string==nil
    contacts = Contact.find(string)
  else
    print "Search For: "
    contacts = Contact.find(STDIN.gets.chomp)
  end
  contacts.each do |contact|
    puts "#{contact.id}: #{contact.name}(#{contact.email}) - Phone: #{contact.phone}"
  end
end

def delete_contact
  Contact.all.each do |contact|
    puts "#{contact.id}: #{contact.name}(#{contact.email}) - Phone: #{contact.phone}"
  end
  puts "\n\nWhich contact would you like to delete?"
  print "id: "
  id = STDIN.gets.chomp
  Contact.delete_contact(id)
  puts "id: #{id} has been deleted"
end


def execute(command, id=nil)
  case command
    when "help" then help_menu
    when "new"  then new_contact
    when "update"  then update_contact
    when "list" then list_all_contact
    when "show" then id == nil ? show_a_contact : show_a_contact(id)
    when "find" then id == nil ? find_a_contact : find_a_contact(id)
     when "delete" then delete_contact
    else
      puts "I dont understand your command... good day"
  end

end

def run
  command = ARGV[0]
  id = ARGV[1]
  execute(command, id)
end

connect
run


# contact.each do |con|
#   con.email = 'Judy@gmail.com'.downcase
#   con.name = 'Judy wong'.capitalize
#   con.phone = set_phone
# end
# contact.save

