class Toy < ApplicationRecord
    validates :name, presence: true
    validates :name, uniqueness: true
    validates :name, length: { minimum: 2 }
    validates :name, length: { maximum: 25 }
    validates :image, presence: true
    validates :image, length: { maximum: 250 }
end
