require 'rails_helper'
require 'byebug'

RSpec.describe StudentQueuesController, type: :controller do
  describe 'wait time' do
    before(:each) do
      @fake_student_request = double('StudentQueue', :id => 1, :student_id => 1)
      @fake_student_request2 = double('StudentQueue', :id => 2, :student_id => 2)
      allow(Student).to receive(:where)
      #allow(StudentQueue).to receive(:where).and_return(@fake_student_request)
    end
    subject { get 'wait_time', :id => @fake_student_request.id}
    it 'retrieves the students waiting in the queue' do
      @fake_results = [@fake_student_request, @fake_student_request2]
      allow(StudentQueue).to receive(:order).with("created_at").and_return(@fake_results)
      subject
      expect(assigns(:sorted_results)).to eq(@fake_results)
    end
    it 'finds the correct wait position' do
      @fake_results = [@fake_student_request, @fake_student_request2]
      allow(StudentQueue).to receive(:order).with("created_at").and_return(@fake_results)
      subject
      expect(assigns(:wait_pos)).to eq(0)
    end
    it 'calculates the correct wait time' do
      @fake_results = [@fake_student_request, @fake_student_request2]
      allow(StudentQueue).to receive(:order).with("created_at").and_return(@fake_results)
      subject
      expect(assigns(:wait_time)).to eq(0)
    end
  end

  describe 'view index' do
    before(:each) do
      @fake_student_request = double('StudentQueue', :id => 1, :student_id => 1)
      @fake_student_request2 = double('StudentQueue', :id => 2, :student_id => 2)
      #allow(StudentQueue).to receive(:where).and_return(@fake_student_request)
    end
    it "properly sort" do
      allow(StudentQueue).to receive(:order).with("created_at").and_return(@fake_results)
      expect(assigns(:queue_entries)).to eq(@fake_results)
      get :index
    end
  end

  describe 'enter line' do
    before :each do
      @params = {:student_first_name => 'Athina',
                 :student_last_name => 'Kaunda',
                 :student_sid => '23636173',
                 :student_course => 'math',
                 :student_email => 'student@email.com'}

      @student_data = {:first_name => @params[:student_first_name],
                       :last_name => @params[:student_last_name],
                       :sid => @params[:student_sid],
                       :email => @params[:student_email]}

      @student = FactoryGirl.build(:student, @student_data)
    end
    it 'checks the Student model if the student exists.' do
      expect(Student).to receive(:where).with(:sid => @params[:student_sid]).and_return([])
      post :create, @params
    end

    describe 'after the student signs up' do
      it 'creates the student if the student does not exists in the database' do
        allow(Student).to receive(:where).with(:sid => @params[:student_sid]).and_return([])
        expect(Student).to receive(:create).with(@student_data).and_return(@student)
        post :create, @params
      end
      it 'adds the student to the queue' do
        post :create, @params
        expect(@student.student_queue).to_not be_nil
        expect(@student.student_queue.course).to eq(@params[:student_course])
        expect(StudentQueue.find(@student.sid).student).to eq(@student)
      end
      it 'looks up the student from the database if they are already there.' do
        allow(Student).to receive(:where).with(:sid => @params[:student_sid]).and_return([@student])
        expect(Student).to receive(:find).with(@params[:student_sid]).and_return(@student)
        post :create, @params
      end

    end

    describe 'if the student does not want to wait' do
      before :each do
        @id = {:id => @params[:student_sid]}
        @student.build_student_queue
        @student.save
      end
      it 'retrieves the student from the data base' do
        expect(Student).to receive(:find).with(@id[:id]).and_return(@student)
        post :destroy, @id
      end
      it 'writes the student to the drop in histroy' do
        # expect(@student).to receive(:queue_to_history) #how to stub instance method?
        post :destroy, @id
        expect(@student.drop_in_histories).not_to be_empty
      end
      it 'removes the student from the queue' do
        allow(Student).to receive(:find).with(@id[:id]).and_return(@student)
        expect(StudentQueue).to receive(:destroy).with(@student)
        post :destroy, @id
      end
    end
  end
end
