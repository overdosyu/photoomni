class UserProfile < ActiveRecord::Base
  belongs_to :user
  attr_accessible :first_name, :last_name, :avatar

  has_attached_file :avatar,
    :styles => {
      :size_150_by_150 => "150x150#",
      :size_25_by_25 => "25x25#" },
    :storage => :s3,
    :s3_credentials => "#{Rails.root}/config/s3.yml",
    :path => "user_profile/avatar/:style/:id/:filename",
    :default_url => "user_profile/avatar/:style/missing.png"


  def full_name
    "#{first_name} #{last_name}"
  end

end
