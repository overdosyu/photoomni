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

  def avatar_url(size)
    if !avatar.present? && self.user.provider == "facebook"
      width_and_height = case size
      when :size_25_by_25
        "width=25&height=25"
      else
        "width=150&height=150"
      end
      "https://graph.facebook.com/#{self.user.uid}/picture?#{width_and_height}"
    else
      avatar.url(size).to_s
    end
  end

end
