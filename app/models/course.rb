class Course < ApplicationRecord
  belongs_to :type
  belongs_to :school

  scope :closest, -> { where("date > ?", (DateTime.now)) }
  scope :latest, -> { closest.order(event_at: :desc) }
end
