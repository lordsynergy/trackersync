# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Redmine API' do
  let(:issues) { Redmine::Issue.all }
  let(:issue_titles) { ['Test Task 1', 'Test Task 2'] }

  before(:all) do
    ['Test Task 1', 'Test Task 2'].each do |title|
      Redmine::Issue.create!(subject: title, project_id: 'test-project')
    end
  end

  describe 'Issues existence' do
    it 'verifies all issues exist in Redmine' do
      titles = issues.map(&:subject)
      issue_titles.each do |title|
        expect(titles).to include(title)
      end
    end
  end

  describe 'Issues accessibility' do
    it 'verifies all tasks are accessible via their IDs' do
      issues.each do |issue|
        fetched_issue = Redmine::Issue.find(issue.id)
        expect(fetched_issue.subject).to eq(issue.subject)
      end
    end
  end
end
