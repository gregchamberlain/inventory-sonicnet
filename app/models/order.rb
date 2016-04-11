class Order < ActiveRecord::Base

  belongs_to :from, class_name: 'Location', foreign_key: 'from_location'
  belongs_to :to, class_name: 'Location', foreign_key: 'to_location'

  has_many :orderables
  accepts_nested_attributes_for :orderables, reject_if: :all_blank, allow_destroy: true

end
