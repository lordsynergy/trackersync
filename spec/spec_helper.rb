# frozen_string_literal: true

require 'dotenv/load'
require 'json'

Dir[File.join(__dir__, '../lib/**/*.rb')].sort.each { |file| require file }
