class Settings < Settingslogic
  if Rails.env == :production
    source "#{Rails.root}/config/application.yml"
  else
    source "#{Rails.root}/config/development.yml"
  end
  namespace Rails.env
end
