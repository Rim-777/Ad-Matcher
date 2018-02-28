class Report < ActiveRecord::Base
  validates :verification, :message,  presence: true
  belongs_to :verification
end