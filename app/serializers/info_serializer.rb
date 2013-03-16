class InfoSerializer < ActiveModel::Serializer
  attributes :id, :name, :role_text, :mail, :link, :full_text
  
  def role_text
    object.custom_role_name
  end

  def full_text
    object.description.gsub("\t", "").strip
  end
end
