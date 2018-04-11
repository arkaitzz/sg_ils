class Address < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    line1   :string
    line2   :string
    city    :string
    state   :string
    zip     :integer
    phone   :integer
    timestamps
  end
  attr_accessible :line1, :line2, :city, :state, :zip, :phone, :user, :user_id

  # --- Relations --- #
  belongs_to :user

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

  def view_permitted?(field)
    true
  end

end
