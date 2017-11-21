class Request < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    start_time   :datetime
    place        :string
    duration     :integer
    observations :text
    timestamps
  end
  attr_accessible :start_time, :place, :duration, :observations, :user #, :interpreter SE ASIGNA EL PROPIO INTERPRETE SUS REQUESTS

  belongs_to :user #The creator f the request
  belongs_to :interpreter, :class_name => "User" #The interprete that is going to assist this request.

  # --- Permissions --- #

  def create_permitted?
    acting_user.administrator? || acting_user.applicant?
  end

  def update_permitted?
    acting_user.administrator?
  end

  def destroy_permitted?
    acting_user.administrator?
  end

  def view_permitted?(field) #Only an admin or interpreters can view every request. Applicants only thier requests.
    acting_user.administrator? || acting_user.interpreter? || acting_user == self.user
  end

end
