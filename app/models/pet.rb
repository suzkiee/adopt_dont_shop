class Pet < ApplicationRecord
  validates :name, presence: true
  validates :age, presence: true, numericality: true
  belongs_to :shelter
  has_many :pet_applications, dependent: :destroy
  has_many :applications, through: :pet_applications, dependent: :destroy
  
  def self.partial_search(result)
    where("name ILIKE ?", "%#{result}%")
  end

  def shelter_name
    shelter.name
  end

  def self.adoptable
    where(adoptable: true)
  end
end
