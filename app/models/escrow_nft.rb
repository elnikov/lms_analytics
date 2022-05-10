class EscrowNFT < ApplicationRecord
  include HistoryMethod

  enum kind: [:lms]
  enum status: [:on_sale, :in_use]

  enum rarity: {
    zero: 0,
    one: 1,
    uncommon: 2,
    rare: 3,
    epic: 4,
    legendary: 5
  }

  def lms_url
    "https://market.letmespeak.org/#/escrow/#{lms_id}"
  end

  def rarity
    attrs['rarity']
  end

  def rarity_human
    case rarity
    when 2
      'uncommon'
    when 3
      'rare'
    when 4
      'epic'
    when 5
      'legendary'
    else
      'unknown'
    end
  end

  def simple_dayleft
    formula.try(:[], 'simple_dayleft')
  end

  def method_missing(method, *args, &block)
    attrs[method.to_s]
  end

  before_save :update_formulas

  def update_formulas
    update_simple_dayleft
  end

  def update_simple_dayleft
    formula['simple_dayleft'] = ((visa_left * max_daily_earning) - price.to_i).round(1)
  end

  def visa_human
    "#{visa_left}/#{visa_total}"
  end

  def max_daily_earning
    lstars = case rarity
             when 2
               105
             when 3
               232
             when 4
               427
             when 5
               1136
             else
               0
             end
    lstars * 0.02
  end


  def self.update_escrow
    on_sales_id = []
    items = LMSParse.new.parse
    items.each do |item|
      nft = EscrowNFT.find_or_initialize_by nft_number: item.dig('nft', 'details', 'name'), kind: :lms

      attr = item.dig('nft', 'details', 'attributes')
      attr.each do |at|
        nft.attrs[at['trait_type']] = at['value']
      end

      nft.mongo_id = item['_id']
      nft.lms_id = item['id']
      nft.nft = item['nft']
      nft.price = item['price']
      nft.seller = item['seller']
      nft.mint = item['mint']
      nft.nft_vault = item['nftVault']
      nft.seller_receive_account = item['sellerReceiveAccount']
      nft.escrow_date = Time.at(item['date']).to_datetime
      nft.human_name = item.dig('nft', 'details', 'attributes').first['value']
      nft.image_url = item.dig('nft', 'details', 'image')
      nft.status = :on_sale
      nft.save
      byebug unless nft.save
      on_sales_id << nft.id
    end
    EscrowNFT.where.not(id: on_sales_id).update_all(status: :in_use)
  end

end
