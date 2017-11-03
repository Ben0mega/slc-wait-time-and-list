require 'uri'
require 'cgi'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))

module WithinHelpers
  def with_scope(locator)
    locator ? within(locator) { yield } : yield
  end
end
World(WithinHelpers)

Given /^I'm on the app sign in page$/ do
  pending
end

Given /^I fill in the password correctly$/ do
  pending
end

Given /^I should be told that the password is incorrect$/ do
  pending
end

Given /^I'm on the student sign in page$/ do
  pending
end

Given /^I am signed in to the app$/ do
  pending
end

Given /^I should not be redirected$/ do
  pending
end

Given /^I am not signed in to the app/ do
  pending
end

Given /^I should be redirected to the password login/ do
  pending
end

Given /^I'm on the student queues page/ do
  pending
end

Given /^I fill in the password incorrectly/ do
  pending
end

Given /^I am signed in as a tutor/ do
  pending
end

Given /^I should not be redirected/ do
  pending
end

Given /^I am not signed in as a tutor/ do
  pending
end

Given /^I should be redirected to the student sign in page/ do
  pending
end

Given /^I should be redirected to the app sign in page/ do
  pending
end

Given /^I should be logged out as a tutor/ do
  pending
end

Given /^I should be redirected to app sign in page/ do
  pending
end



