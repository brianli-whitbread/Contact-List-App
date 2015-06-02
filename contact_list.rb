require_relative 'contact'
require_relative 'contact_database'

def help_menu
  print "\n\nHere is a list of available commands:\n
    new  - Create a new contact\n
    list - List all contacts\n
    show - Show a contact\n
    find - Find a contact\n\n > "
    execute(STDIN.gets.chomp)
end

def new_contact
  puts "Add New Contact"
  print "Name: "
  name = STDIN.gets.chomp
  print "Email: "
  email = STDIN.gets.chomp
  Contact.create(name, email)
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

def find_a_contact(index=nil)
  puts "Find Contact by Contact List Index"
  unless index==nil
    Contact.find(index)
  else
    print "Index: "
    Contact.find(STDIN.gets.chomp)
  end
end

def execute(command, id)
  case command
    when "help" then help_menu
    when "new"  then new_contact
    when "list" then list_all_contact
    when "show" then show_a_contact(id)
    when "find" then find_a_contact(id)
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



