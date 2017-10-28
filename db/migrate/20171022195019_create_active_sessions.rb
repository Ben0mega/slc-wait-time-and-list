class CreateActiveSessions < ActiveRecord::Migration
  def change
    create_table :active_sessions do |t|
      t.integer :student_id #should be foreign key.
      t.string :course
      t.time :wait_time #@activeSession.createtime - @studentQueue.createtime
      #*** what will be the values of status? -- "in progress", "waiting"
      t.integer :tutor_id #this should not be here. It should live in drop_in_histories.
      t.timestamps  #sort by create time.
    end
  end
end
