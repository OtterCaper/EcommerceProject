class About < ApplicationRecord
  validates :header, :body, presence: true
end
