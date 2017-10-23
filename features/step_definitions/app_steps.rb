require 'uri'
require 'cgi'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))

module WithinHelpers
  def with_scope(locator)
    locator ? within(locator) { yield } : yield
  end
end
World(WithinHelpers)

Given /the following student queues exist/ do |student_data_table|
  student_data_table.hashes.each do |student_data|
    # delete the create time if it exists, since we want this to go in the queue.
    create_time = student_data[:created_at]
    student_data.delete('created_at')

    student = Student.create(student_data)

    if create_time
      student.build_student_queue(:created_at => create_time)
    else
      student.build_student_queue()
    end
    student.save
  end
end

Given /the following students exist/ do |students_table|
  students_table.hashes.each do |student|
    Student.create student
  end
end

Given /^I am logged in as a tutor$/ do
  pending
end



Then /^I should see a list of students$/ do
    StudentQueue.all.each do |entry|
    step %{I should see "#{entry.student.first_name} #{entry.student.last_name}"}
  end
end

When /^I edit student "(.*)"$/ do |word|
  pending
end



When /^I fill in "(.*)" and "(.*)" times with "(.*)" and "(.*)"$/ do |word|
  pending
end

Then /^I should see "start" filled with "0" and end filled with "0"$/ do |word|
  pending
end

Given /^there are no students$/ do |word|
  pending
end

Given /^a student is on the home page$/ do
  pending
end

Given /^the student clicks sign in$/ do
  pending
end

Given /^I am on the wait time page$/ do
  pending
end

Then /^I should be on the sign up form$/ do
  pending
end

Then /^(?:she|he|I) should be on (.+)/ do |page_name|
    current_path = URI.parse(current_url).path
  if current_path.respond_to? :should
    current_path.should == path_to(page_name)
  else
    assert_equal path_to(page_name), current_path
  end
end

Then /^(?:I|she|he) should not be on (.+)$/ do |page_name|
  current_path = URI.parse(current_url).path
  if current_path.respond_to? :should
    current_path.should_not == path_to(page_name)
  else
    assert_not_equal path_to(page_name), current_path
  end
end

Then /^(?:I|she|he) should see "([^"]*)"$/ do |text|
  if page.respond_to? :should
    page.should have_content(text)
  else
    assert page.has_content?(text)
  end
end

Then /^(?:I|she|he) should see \/([^\/]*)\/$/ do |regexp|
  regexp = Regexp.new(regexp)

  if page.respond_to? :should
    page.should have_xpath('//*', :text => regexp)
  else
    assert page.has_xpath?('//*', :text => regexp)
  end
end

Then /^(?:I|she|he) should not see \/([^\/]*)\/$/ do |regexp|
  regexp = Regexp.new(regexp)

  if page.respond_to? :should
    page.should have_no_xpath('//*', :text => regexp)
  else
    assert page.has_no_xpath?('//*', :text => regexp)
  end
end

Then /^(?:I|she|he) should not see "([^"]*)"$/ do |text|
  if page.respond_to? :should
    page.should have_no_content(text)
  else
    assert page.has_no_content?(text)
  end
end

Then /^I should not be on the sign up form$/ do
  pending
end

When /^I fill out information$/ do
  pending
end

When /^I click on "(.*)"$/ do |button|
  click_button(button)
end

Given /^I am on the sign up form$/ do
  pending
end

Then /^I should see a wait time$/ do
  pending
end

Given /^I am on (.*)$/ do |page_name|
  visit path_to(page_name)
end

When /^I fill in the "(.*)" form and click "(.*)"$/ do |form_type, button|
  
  text_fields = ["student_last_name", "student_first_name", "student_sid", "student_email", "student_course"]
  text_inputs = ["brown", "bob", "12345678", "bobb@berkeley.edu", "english"]
  radio_fields = ["request_type_appointment"]
  
  for i in 0..(text_fields.length-1)
    text_field = text_fields[i]
    text_input = text_inputs[i]
    steps %Q{
      When I fill in "#{text_field}" with "#{text_input}"
    }
  end

  for i in 0..(radio_fields.length-1)
    radio_button = radio_fields[i]
    steps %Q{
      When I click "#{radio_button}"
    }
  end
  steps %Q{
      When I press "Submit"
  }



end

Then /^I should see a wait time of "(.*)"$/ do |wait_time|
  step %{I should see "#{wait_time}"}
end

