Feature: view next student in line
  
  As a tutor
  So that I can decide which student to work with
  I want to see who is next in line
  Background: student requests in database
 
  Given the following student queues exist:
  | sid        | first_name | last_name | waiting? | created_at              |
  | 25804240   | Alex       | Yang      | true     | 2012-09-10 14:44:24 UTC |
  | 00000000   | Haggai     | Kaunda    | false    | 2011-09-10 14:44:24 UTC |
  | 25804241   | Maiki      | Rainton   | true     | 2013-09-10 14:44:24 UTC |
  | 25804242   | Nahrae     | Seok      | true     | 2014-09-10 14:44:24 UTC |

Scenario: list of students in line
  #   Given I am logged in as a tutor
  Given I am on the student line page
  Then I should see a list of students
 
# Scenario: see no students
#   Given I am logged in as a tutor
    And I am on the student line page
    Then I should see "Alex Yang" before "Maiki Rainton"
    And I should see "Alex Yang" before "Nahrae Seok"
  
