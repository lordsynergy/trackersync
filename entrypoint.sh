#!/bin/bash
set -e

/docker-entrypoint.sh rake db:migrate
/docker-entrypoint.sh rake redmine:load_default_data RAILS_ENV=production REDMINE_LANG=en

/docker-entrypoint.sh rails server -b 0.0.0.0 &

echo "Waiting for Redmine to be ready..."
until curl -s http://localhost:3000 > /dev/null; do
  sleep 5
done
echo "Redmine is ready!"

bundle exec rails runner - <<'RUBY'
  begin
    Setting['rest_api_enabled'] = '1'

    project = Project.find_or_create_by!(identifier: 'test-project') do |p|
      p.name = 'Test Project'
    end
    puts 'Project created successfully.'

    user = User.find_or_initialize_by(login: 'testuser')
    unless user.persisted?
      user.assign_attributes(
        firstname: 'Test',
        lastname: 'User',
        mail: 'user@example.com',
        password: 'password',
        password_confirmation: 'password',
        admin: false,
        status: User::STATUS_ACTIVE
      )
      user.save!
      puts 'Test user created successfully.'
    else
      puts 'Test user already exists.'
    end

    user.generate_api_key! unless user.api_key
    puts "Test User API Key: #{user.api_key}"

    if (role = Role.find_by(name: 'Manager'))
      Member.create!(user: user, project: project, role_ids: [role.id])
      puts 'User added to project successfully'
    else
      puts 'No suitable role found. User not added to project.'
    end

    puts 'Setup completed successfully!'
  rescue => e
    warn "An error occurred: #{e.message}"
    warn e.backtrace
    exit 1
  end
RUBY

touch /tmp/redmine_ready

wait