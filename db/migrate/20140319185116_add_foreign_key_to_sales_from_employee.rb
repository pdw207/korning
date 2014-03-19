class AddForeignKeyToSalesFromEmployee < ActiveRecord::Migration
  def up
    add_column :sales, :employee_id, :integer

    Sale.find_each do |legacy_sale|
      email_from_legacy_data = legacy_sale.employee.split(" ")[2].gsub(/(\(|\))/, "")
      legacy_sale.employee_id = Employee.where(email: email_from_legacy_data).take.id
      legacy_sale.save
    end
    add_index :sales, :employee_id
  end

  def down
    remove_index :sales, :employee_id
    remove_column :sales, :employee_id
  end
end
