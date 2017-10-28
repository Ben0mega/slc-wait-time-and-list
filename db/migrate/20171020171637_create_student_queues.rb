class CreateStudentQueues < ActiveRecord::Migration
  def change
    create_table :student_queues do |t|
      
      #entered by student, visible on tutor form
      
      t.integer :student_id #should be foreign key.
      t.string :course
      t.timestamps  #sort by create time.
      
    end
  end
end
