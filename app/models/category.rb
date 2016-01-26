class Category < ActiveRecord::Base
	has_many :meals
	has_attached_file :image, default_url: "categories/placeholder.png"
	validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
	validates :name, presence: true
end
