# frozen_string_literal: true

class DirectoryItemUserSerializer < UserNameSerializer
  include UserPrimaryGroupMixin
  
  def attributes(*args)
    attrs = super
    
    additional_attrs = SiteSetting.user_directory_additional_attributes.split("|")
    serialized_user = UserSerializer.new(object, scope: scope)

    additional_attrs.each do |attr|
      if serialized_user.respond_to?("include_#{attr}?") && serialized_user.send("include_#{attr}?")
        attrs[attr.to_sym] = serialized_user.send(attr)
      end
    end
    
    attrs
  end
end