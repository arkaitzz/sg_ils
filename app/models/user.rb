class User < ActiveRecord::Base

  hobo_user_model # Don't put anything above this

  fields do
    name          :string, :required, :unique
    email_address :email_address, :unique, :login => true
    administrator :boolean, :default => false
    interpreter   :boolean, :default => false
    applicant     :boolean, :default => true
    timestamps
  end
  attr_accessible :name, :email_address, :password, :password_confirmation, :current_password, :addresses

  # --- Relations --- #
  has_many :addresses, :class_name => 'Address'
  has_many :requests
  has_many :interpretation_requests, :class_name => "Request"

  # --- Callbacks --- #
  # This gives admin rights and an :active state to the first sign-up.
  # Just remove it if you don't want that
  before_create do |user|
    if !Rails.env.test? && user.class.count == 0
      user.administrator = true
      user.applicant = false
      user.state = 'active'
    end
  end

  # --- Change user_type --- #
  def become_administrator_allowed?
    ['administrator'].include?(acting_user.profile) && !self.administrator?
  end

  def become_interpreter_allowed?
    ['administrator'].include?(acting_user.profile) && !self.interpreter?
  end

  def become_applicant_allowed?
    ['administrator'].include?(acting_user.profile) && !self.applicant?
  end

  def become_administrator
    self.update_attributes(:applicant => false, :interpreter => false, :administrator => true)
  end

  def become_interpreter
    self.update_attributes(:applicant => false, :interpreter => true, :administrator => false)
  end

  def become_applicant
    self.update_attributes(:applicant => true, :interpreter => false, :administrator => false)
  end

  # --- Lifecycle --- #
  lifecycle do
    state :inactive, :default => true
    state :active

    create :signup, :available_to => "Guest",
      :params => [:name, :email_address, :password, :password_confirmation],
      :become => :inactive, :new_key => true  do
      UserMailer.activation(self, lifecycle.key).deliver
    end

    transition :request_password_reset, { :active => :active }, :new_key => true do
      UserMailer.forgot_password(self, lifecycle.key).deliver
    end

    transition :reset_password, { :active => :active }, :available_to => :key_holder,
               :params => [ :password, :password_confirmation ]

    transition :be_administrator, { :active => :active }, :available_to => :all, :if => :become_administrator_allowed? do
      self.become_applicant
    end

    transition :be_interpreter, { :active => :active }, :available_to => :all, :if => :become_interpreter_allowed? do
      self.become_interpreter
    end

    transition :be_applicant, { :active => :active }, :available_to => :all, :if => :become_applicant_allowed? do
      self.become_applicant
    end

    transition :mark_as_inactive, { :active => :inactive }, :available_to => 'User.administrator'
    transition :mark_as_active, { :inactive => :active }, :available_to => 'User.administrator'
  end

  # --- Aux. methods --- #
  def signed_up?
    state == 'active'
  end

  def profile
    return 'administrator' if administrator?
    return 'interpreter' if interpreter?
    return 'applicant' if applicant?
  end

  # --- Permissions --- #
  def create_permitted?
    true
  end

  def update_permitted?
    acting_user.administrator? ||
      (acting_user == self && only_changed?(:name, :email_address, :crypted_password,
                                            :current_password, :password, :password_confirmation))
    # NOTE: crypted_password has attr_protected so although it is permitted to change, it cannot be changed
    # directly from a form submission.
  end

  def destroy_permitted?
    false
  end

  def view_permitted?(field)
    acting_user == self || 
      acting_user.administrator? || 
      (acting_user.guest? && [:name, :email_address, :password, :password_confirmation].include?(field))
  end
end
