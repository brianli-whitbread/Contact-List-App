require_relative 'contact'
require_relative 'contact_database'

def help_menu
  print "\n\nHere is a list of available commands:\n
    new  - Create a new contact\n
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

def new_contact
  puts "Add New Contact"
  print "Name: "
  name = STDIN.gets.chomp
  print "Email: "
  email = STDIN.gets.chomp
  phone = set_phone
  Contact.create(name, email, phone)
  #loop
  #keep asking user for mobile type, then mobile number
end

def list_all_contact
  puts "List all contacts"
  Contact.all
end

def show_a_contact(id=nil)
  puts "Show a Contact"
  unless id==nil
    Contact.show(id)
  else
    print "Id: "
    Contact.show(STDIN.gets.chomp)
  end
end

def find_a_contact(string=nil)
  puts "Find by Contact Name or Contact Email"
  unless string==nil
    Contact.find(string)
  else
    print "Index: "
    Contact.find(STDIN.gets.chomp)
  end
end

def execute(command, id=nil)
  case command
    when "help" then help_menu
    when "new"  then new_contact
    when "list" then list_all_contact
    when "show" then id == nil ? show_a_contact : show_a_contact(id)
    when "find" then id == nil ? find_a_contact : find_a_contact(id)
    else
      puts "I dont understand your command... good day"
  end

end

def run
  command = ARGV[0]
  id = ARGV[1]
  execute(command, id)
end

run




