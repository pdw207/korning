class CreateProducts < ActiveRecord::Migration
  def up
    # Create Product Table
    create_table :products do |t|
      t.string :name, null: false, uniq: true
      t.integer :price, null: false
      t.timestamps
    end

    # Update Table with legacy data
    Sale.find_each do |sale|
      name = sale.product_name
      recent_sale = Sale.where(product_name: name).order(sale_date: :desc).limit(1).take
      current_price = (recent_sale.sale_amount / recent_sale.units_sold).to_f.round(2)*100
    
      Product.find_or_initialize_by(name: name, price: current_price){|product|product.save!}
    end
  end

  def down
    drop_table :products 
  end
end
