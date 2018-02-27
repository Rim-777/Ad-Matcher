class Verification < ActiveRecord::Base
  validates :campaign_list, presence: true
  has_many :campaigns, dependent: :destroy
  has_many :reports, dependent: :destroy
end
