class Sale < ActiveRecord::Base
  belongs_to :customer
  belongs_to :employee
  has_many :invoices
  has_many :product_sales
  has_many :products, through: :product_sales
end
