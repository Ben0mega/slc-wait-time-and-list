class CreateTutorWorkDays < ActiveRecord::Migration
  def change
    create_table :tutor_work_days do |t|
      t.integer :tutor_id
      t.integer :start_time
      t.integer :end_time
      t.string :num_students

      t.timestamps null: false
    end
  end
end
