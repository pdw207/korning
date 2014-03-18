class MoveCustomerData < ActiveRecord::Migration

  def change
    add_column :sales, :customer_id, :integer

    Sale.find_each do |e|
      account = e.customer_and_account_no.split(" ")[1].gsub(/(\(|\))/, "")
      name = e.customer_and_account_no.split(" ")[0]
      c = Customer.find_or_create_by(name: name, account_number: account)


      e.customer_id = c.id
      e.save
    end


    add_index :sales, :customer_id
  end

end
