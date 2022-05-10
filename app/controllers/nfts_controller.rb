class NFTsController < ApplicationController
  def index
    @nfts = EscrowNFT.all.order(Arel.sql("cast(formula->>'simple_dayleft' as float) DESC")).where(status: 'on_sale')
  end

  def show
  end
end
