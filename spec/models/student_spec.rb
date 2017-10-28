require 'rails_helper'
require 'byebug'

RSpec.describe Student, type: :model do
  describe 'If a student does not want to wait in line' do
    before :each do
      student_info = {:first_name => 'Haggai',
                      :last_name => 'Kaunda',
                      :sid => 123456,
                      :email => 'student@email.edu'}
      @student = FactoryGirl.build(:student, student_info)
      @student.build_student_queue(:course => 'Greek')
      @student.queue_to_history
    end
    it 'moves the student to the drop_in_history' do

      expect(@student.drop_in_histories).not_to be_empty
    end
    describe 'it sets drop_in_attribute accordingly' do
      before :each do
        @drop_in_history = @student.drop_in_histories[0]
      end
      it 'records what course the student wanted tutoring for.' do
        expect(@drop_in_history.course).to eq(@student.student_queue.course)
      end
      it 'indicates that the student canceled.' do
        expect(@drop_in_history.status).to eq('canceled')
      end
    end

  end

  describe 'when erasing a student from the student_queue' do
    before :each do
      student_info = {:first_name => 'Athina',
                      :sid => 11234832}
      @student = FactoryGirl.build(:student, student_info)
    end
    it 'checks if the student has a entry in the student queue' do
      expect(@student).to receive(:student_queue)
      @student.destroy_student_queue
    end
    describe 'if the student has a entry in the student queue' do
      before :each do
        @student_queue = FactoryGirl.build(:student_queue, :student_id => @student.sid)
        allow(@student).to receive(:student_queue).and_return(@student_queue)
      end
      it 'it destroys the entry in the queue if the student has an entry' do
        expect(@student_queue).to receive(:destroy)
        @student.destroy_student_queue
      end
      it 'sets student_queue of current student to nil' do
        expect(@student).to receive(:student_queue=).with(nil)
        @student.destroy_student_queue
      end
      it 'saves the updated student.' do
        expect(@student).to receive(:save)
        @student.destroy_student_queue
      end
    end
  end
end
