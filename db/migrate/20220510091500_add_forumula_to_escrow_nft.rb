class AddForumulaToEscrowNFT < ActiveRecord::Migration[7.0]
  def change
    add_column :escrow_nfts, :formula, :json, default: {}
  end
end
