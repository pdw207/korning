class CreateEmployees < ActiveRecord::Migration
  def up
    create_table :employees do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email, uniq: true
      t.timestamps
    end
    #Update Table with Employee data
    Sale.find_each do |e|
      first_name, last_name, email = e.employee.split(" ")
      email = email.gsub(/(\(|\))/, "")
      Employee.find_or_create_by(first_name: first_name, last_name: last_name, email: email)
    end
  end

  def down
    drop_table :employees
  end
end
