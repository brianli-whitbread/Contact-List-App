class Cli


  def view_all
    Contact.all.each do |contact|
      puts "id: #{contact.id}, #{contact.first_name} #{contact.last_name}, #{contact.phone}"
    end
  end

  def find_by_id(id)
    contact = Contact.find(id)
    puts "id: #{contact.id}, #{contact.first_name} #{contact.last_name}, #{contact.phone}"
  end

  def find_by_first_name(first_name)
    contact = Contact.where(["lower(first_name) LIKE lower(?)", "%#{first_name}"]).first
    puts "id: #{contact.id}, #{contact.first_name} #{contact.last_name}, #{contact.phone}"
  end

  def find_by_last_name(last_name)
    contact = Contact.where(["lower(last_name) LIKE lower(?)", "%#{last_name}"]).first
    puts "id: #{contact.id}, #{contact.first_name} #{contact.last_name}, #{contact.phone}"
  end

  def find_by_email(email)
    contact = Contact.where(["lower(email) LIKE lower(?)", "%#{email}%"]).first
    puts "id: #{contact.id}, #{contact.first_name} #{contact.last_name}, #{contact.phone}"
  end

  #new_contact
  def new_contact
    print "First Name: "
    first_name = STDIN.gets.chomp.titleize
    print "Last Name: "
    last_name = STDIN.gets.chomp.titleize
    email = set_email.downcase
    phone = set_phone
    contact = Contact.new(first_name: first_name, last_name: last_name, email: email, phone: phone)
    contact.save
    puts "#{first_name} #{last_name} (#{email}) has been saved."
  end

  #update
  def update
    view_all
    puts "\n\nWhich contact would you like to update?"
    print "id: "
    contact = Contact.find(STDIN.gets.chomp.to_i)
    print "You must fill in every field!\n--------------------------\n"
    print "First Name: "
    contact.first_name = STDIN.gets.chomp.titleize
    print "Last Name: "
    contact.last_name = STDIN.gets.chomp.titleize
    contact.email = set_email
    contact.phone = set_phone
    contact.save
    puts "#{contact.id}: #{contact.first_name} #{contact.last_name} (#{contact.email}) - Phone: #{contact.phone} has been UPDATED!" 
  end

  def delete
    view_all
    puts "\n\nWhich contact would you like to delete?"
    print "id: "
    contact = Contact.find(STDIN.gets.chomp.to_i)
    puts "#{contact.id}: #{contact.first_name} #{contact.last_name} (#{contact.email}) - Phone: #{contact.phone} has been DELETED!" 
    contact.destroy
  end

  
  #setemail
  def set_email
  ask_for_email = true
  while ask_for_email
    print "Email: "
    email = STDIN.gets.chomp.downcase
    unless email.match /.*\@.*$/
      puts "Sorry, your email is not in the correct format"
    else
      unless Contact.exists?(email:"#{email}")
        return email
      else
        puts "Your email is already used. Please input another email address"
      end
    end
  end
end

def set_phone
  phone_numbers = ''
  adding_phone_numbers = true
  while adding_phone_numbers
    phone_numbers << "; " unless phone_numbers.empty?
    puts "Label for the Phone Number"
    print "> "
    phone_numbers << STDIN.gets.chomp.titleize + ":"
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

  def execute(command, id=nil)
    case command
      when "help" then help_menu
      when "new"  then new_contact
      when "update" then update
      when "delete" then delete
      when "view_all" then view_all
      when "find_by_id" then find_by_id
      when "find_by_first_name" then find_by_first_name
      when "find_by_last_name" then find_by_last_name
      when "find_by_last_name" then find_by_emil
      else
        puts "I dont understand your command... good day"
    end
  end

  def help_menu
    print "\n\nHere is a list of available commands:\n
      new  - Create a new contact\n
      upate  - Create a new contact\n
      delete  - Delete a new contact\n
      view all - View all Contacts\n
      find_by_id - Find Contact by ID\n
      find_by_first_name - Find Contact by First Name\n
      find_by_last_name - Find Contact by Last Name\n
      find_by_email - Find Contact by Email\n"
      execute(STDIN.gets.chomp)
  end


  def start
  connect
  command = ARGV[0]
  id = ARGV[1]
  execute(command, id)
  end

end