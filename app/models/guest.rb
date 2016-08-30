class Guest < Hobo::Model::Guest

  def administrator?
    false
  end

  def interpreter?
    false
  end

  def applicant?
    false
  end

end
