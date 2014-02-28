class AddDelayByToRecord < ActiveRecord::Migration
  def change
    add_column :records, :delay_by, :integer
  end
end
