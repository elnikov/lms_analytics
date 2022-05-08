class NFTsController < ApplicationController
  def index
    @nfts = EscrowNFT.all
  end

  def show
  end
end
