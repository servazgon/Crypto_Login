class CreateCryptosTable < ActiveRecord::Migration[5.2]

  def self.up
    create_table :cryptos do |t|
      t.integer :crypto_id
      t.string  :symbol
      t.string  :name
      t.decimal :market_cap, :precision=>64, :scale=>12  
      t.decimal :price, :precision=>64, :scale=>12  
   
      t.timestamps
    end
    add_index :cryptos, :crypto_id,	unique: true

  end

  def self.down
    drop_table :cryptos
  end

end