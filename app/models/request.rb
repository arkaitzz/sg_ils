class Request < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    start_time    :datetime
    place         :string
    duration      :integer
    observations  :text
    confirmed     :boolean, :default => false
    timestamps
  end
  attr_accessible :start_time, :place, :duration, :observations, :user

  default_scope { where(confirmed: true) }

  # --- Relations --- #
  belongs_to :user # The creator of the request (applicant).
  belongs_to :interpreter, :class_name => 'User' # The interpreter that is going to assist this request.

  # --- Aux. methods --- #
  def confirm_after_review
    self.update_attribute(:confirmed, true)
  end

  # --- Permissions --- #
  def create_permitted?
    acting_user.administrator? || 
      acting_user.applicant?
  end

  def update_permitted?
    acting_user.administrator?
  end

  def destroy_permitted?
    acting_user.administrator?
  end

  def view_permitted?(field) # Only an admin or interpreters can view every request. Applicants only thier requests.
    acting_user.administrator? || 
      acting_user.interpreter? || 
      acting_user == self.user
  end

end
