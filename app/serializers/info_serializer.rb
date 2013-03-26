class InfoSerializer < ActiveModel::Serializer
  attributes :id, :name, :role_text, :role_description, :mail, :link, :full_text
  
  def role_text
    if object.role.present?
      object.role.name
    else
      object.custom_role_name
    end
  end
  
  def role_description
    object.role.try(:description)
  end

  def full_text
    object.description.gsub("\t", "").strip
  end
end
