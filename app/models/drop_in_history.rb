class DropInHistory < ActiveRecord::Base
    belongs_to  :student
    has_one :tutor
end
