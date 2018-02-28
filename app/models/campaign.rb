class Campaign < ActiveRecord::Base
  validates :verification,
            :self_reference,
            :external_reference,
            :status,
            presence: true

  belongs_to :verification
  has_one :ad, dependent: :destroy

  enum status: { active: 0, paused: 1, deleted: 2 }
end

