class Contact < ActiveRecord::Base
  
  validates :first_name, :last_name, :email, :phone, presence: true, length: { minimum: 8, message: "Your input is invalid" }

  # def custom_validations
  #   # if booleans
  #     binding.pry
  #     errors.add(:symbole, message")
  #     errors.add(:symbole, message")
  #   # end
  # end

end