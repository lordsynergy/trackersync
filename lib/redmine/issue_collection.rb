module Redmine
  class IssueCollection < ActiveResource::Collection
    def initialize(parsed = {})
      @elements = parsed['issues']
    end
  end
end
