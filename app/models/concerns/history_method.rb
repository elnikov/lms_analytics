module HistoryMethod
  extend ActiveSupport::Concern
  included do
    include ActiveModel::Dirty

    has_many :histories, as: :historyable, dependent: :destroy
    before_update :write_history
    after_create :create_history

    private

    def create_history
      self.attributes.each do |attribute_name, value|

        next if next_fields.include? attribute_name

        History.create!(
          historyable_type: self.class.name,
          historyable_id: id,
          attribute_name: attribute_name,
          before_value: nil,
          after_value: value,
          owner_id: nil
        )
      end
    end

    def next_fields
      [ 'updated_at', 'created_at', 'mongo_id']
    end

    def write_history
      ActiveSupport::Deprecation.silence do


        changes.each do |attribute_name, values|
          before_value = values.first.to_s
          after_value = values.last.to_s
          user_id = nil

          next if before_value == after_value
          next if next_fields.include? attribute_name

          History.create!(
            historyable_type: self.class.name,
            historyable_id: id,
            attribute_name: attribute_name,
            before_value: before_value,
            after_value: after_value
          )

        end
      end
    end

  end
end
