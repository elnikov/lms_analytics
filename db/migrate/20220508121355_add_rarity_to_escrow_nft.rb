class AddRarityToEscrowNFT < ActiveRecord::Migration[7.0]
  def change
    add_column :escrow_nfts, :attrs, :json, default: {}
  end
end
