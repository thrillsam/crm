class AddTeamIdToTicket < ActiveRecord::Migration[6.0]
  def change
    add_column :tickets, :team_id, :integer
  end
end
