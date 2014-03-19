class CreateCustomers < ActiveRecord::Migration
  def up
      # Create Customer Table
      create_table :customers do |t|
      t.string :name, null: false
      t.string :account_number, null: false
      t.timestamps
      end
      # Update Table with legacy data
      Sale.find_each do |e|
      account = e.customer_and_account_no.split(" ")[1].gsub(/(\(|\))/, "")
      name = e.customer_and_account_no.split(" ")[0]
      Customer.find_or_create_by(name: name, account_number: account)
 
      end
  end

  def down
    drop_table :customers 
  end
end
