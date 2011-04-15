class ConferencesUsers < ActiveRecord::Base
  belongs_to :conference_id
  belongs_to :user_id
end
