class CreateEscrowNfts < ActiveRecord::Migration[7.0]
  def change
    create_table :escrow_nfts do |t|
      t.string :mongo_id
      t.string :lms_id
      t.json :nft, default: {}
      t.string :name
      t.string :url
      t.string :nft_address
      t.decimal :price, precision: 40, scale: 20
      t.string :seller
      t.string :mint
      t.string :nft_vault
      t.string :seller_receive_account
      t.datetime :escrow_date
      t.integer :kind
      t.string :human_name

      t.timestamps
    end
  end
end
