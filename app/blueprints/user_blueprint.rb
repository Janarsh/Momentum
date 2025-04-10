class UserBlueprint < Blueprinter::Base
  identifier :id

  fields :first_name, :last_name, :email

  field :full_name do |user, _options|
    "#{user.first_name} #{user.last_name}"
  end
end
