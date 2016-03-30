# Load the Rails application.
require File.expand_path('../application', __FILE__)

ActionMailer::Base.smtp_settings = {
  user_name: 'Nazarcuk',
  password: 'real2010',
  domain: 'bb-region.gq',
  address: 'smtp.sendgrid.net',
  port: 587,
  authentication: :plain,
  enable_starttls_auto: true
}
# Initialize the Rails application.
Rails.application.initialize!
