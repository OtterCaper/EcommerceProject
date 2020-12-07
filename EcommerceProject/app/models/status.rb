class Status < ApplicationRecord
  has_many :orders

  def to_s
    state
  end
end
