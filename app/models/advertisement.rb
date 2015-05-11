class Advertisement < ActiveRecord::Base

	validates :tel, format: { with: /\d{3}\s\d{3}\s\d{2}\s\d{2}/ ,
												message: "wrong format" }
	validates :course, numericality: { greater_than: 0 }, presence: true, length: { maximum: 5 }
	validates :sum, numericality: { greater_than: 0 }, presence: true, length: { maximum: 5 }
	
	belongs_to :user
	
end
