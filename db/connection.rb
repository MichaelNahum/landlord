require 'pg'
require 'active_record'

ActiveRecord::Base.establish_connection(
:adapter => "postgresql",
:database => "landlord" #might should be landlord_db
)
