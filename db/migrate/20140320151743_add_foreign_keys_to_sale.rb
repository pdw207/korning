class AddForeignKeysToSale < ActiveRecord::Migration
  def change
    Sale.find_each do |s|
      email = s.employee.split(" ")[2].gsub(/(\(|\))/, "")
      s.employee_id = Employee.where(email: email).take.id
      
      account = s.customer_and_account_no.split(" ")[1].gsub(/(\(|\))/, "")
      s.customer_id = Customer.where(account_number: account).take.s
      id.save!
    end

  end
end
