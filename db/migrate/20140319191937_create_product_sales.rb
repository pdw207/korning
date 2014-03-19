class CreateProductSales < ActiveRecord::Migration
  def up
    create_table :product_sales do |t|
      t.integer :units, default: 1
      t.integer :product_id, null: false
      t.integer :sale_id, null: false
      t.timestamps
    end

    Sale.find_each do |e|
      new_row = ProductSale.new
      new_row.sale_id = e.id
      new_row.units = e.units_sold
      new_row.product_id = Product.where(name: e.product_name).take.id
      new_row.save
    end

    add_index :product_sales, :product_id
    add_index :product_sales, :sale_id
  end

  def down
    drop_table :product_sales
  end
end
