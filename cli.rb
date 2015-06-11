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

  #create
  def create
    print "First Name: "
    first_name = STDIN.gets.chomp.capitalize
    print "Last Name: "
    last_name = STDIN.gets.chomp.capitalize
    email = set_email
    phone = set_phone
    contact = Contact.new(first_name: '#{first_name}', last_name: '#{last_name}', email: '#{email}', phone: '#{phone}')
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
  return phone_numbers.capitalize
  end

  #update
  def update
  end

  


  def start
    create
  end

end