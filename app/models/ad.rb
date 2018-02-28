class Ad < ActiveRecord::Base
  validates :status, :campaign,  presence: true
  belongs_to :campaign

  enum status: { enabled: 0, disabled: 1}
end