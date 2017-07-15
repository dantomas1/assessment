class Glove < ActiveRecord::Base

  scope :duplis, -> { select(:transaction_id,:glove_type).group(:transaction_id,:glove_type).having("count(*) > 1") }

end
