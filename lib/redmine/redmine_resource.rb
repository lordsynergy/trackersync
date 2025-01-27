require 'active_resource'

module Redmine
  class RedmineResource < ActiveResource::Base
    self.site = ENV.fetch('REDMINE_URL', 'http://localhost:3000')
    headers['X-Redmine-API-Key'] = ENV.fetch('REDMINE_API_KEY', nil)
    self.include_root_in_json = true
  end
end
