class AddForeignKeyToSales < ActiveRecord::Migration

  def up
    add_column :sales, :customer_id, :integer

    Sale.find_each do |legacy_sale|


      account_from_legacy_data = legacy_sale.customer_and_account_no.split(" ")[1].gsub(/(\(|\))/, "")
    

      legacy_sale.customer_id = Customer.where(account_number: account_from_legacy_data).take.id
      legacy_sale.save
    end


    add_index :sales, :customer_id
  end

  def down
    remove_index :sales, :customer_id
    remove_column :sales, :customer_id
  end

end
