# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_hostel_session',
  :secret      => '1cccb34c88892c7459b515bf2aaf3f481e522eb5d5193b0cd7107538a3956fbbf674689c09b209692e3a32c28b11d0f0d29769e366164cb8aea556be4f07d001'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
