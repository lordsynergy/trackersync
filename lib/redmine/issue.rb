require_relative 'redmine_resource'
require_relative 'issue_collection'

module Redmine
  class Issue < RedmineResource
    self.collection_parser = IssueCollection
  end
end