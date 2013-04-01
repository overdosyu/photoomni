class AddAttachmentAvatarToUserProfiles < ActiveRecord::Migration
  def change
    add_attachment :user_profiles, :avatar
  end
end
