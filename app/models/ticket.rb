class Ticket < ApplicationRecord
	enum status: [:initiated, :assigned, :in_progress, :compleated]
	
	belongs_to :team
	
	scope :created_today, -> { where(created_at: Date.today).count}
	scope :created_yesterday, -> { where(created_at: Date.yesterday).count}
end
