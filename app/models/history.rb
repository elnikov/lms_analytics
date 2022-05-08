class History < ApplicationRecord
  belongs_to :historyable, polymorphic: true

  def record
    historyable
  end
end
