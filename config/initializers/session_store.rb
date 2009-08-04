# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_homes_session',
  :secret      => '4a18c12e8779c35780cf5f5c5fec9283969da46d84afe8ca3c02e150a5a616f10ef59cdfb01738332c27c2359372cba627697b45eec0d47c7788a0a5582f723d'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
