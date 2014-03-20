class CreateInvoices < ActiveRecord::Migration
  def up
    create_table :invoices do |t|
      t.string :number, null: false, uniq: true
      t.integer :sale_id, null: false
      t.datetime :date
      t.string :status
      t.timestamps
    end

    Sale.find_each do |sale|
      invoice_no = sale.invoice_no
      Invoice.find_or_initialize_by(number: invoice_no) do |invoice| 
        invoice.sale_id = sale.id
        invoice.save!
      end
    end
    add_index :invoices, :sale_id
  end

  def down
    drop_table :invoices
  end
end
