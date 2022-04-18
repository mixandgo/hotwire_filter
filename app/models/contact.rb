class Contact < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true
  validates :dob, presence: true
end
