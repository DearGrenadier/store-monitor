AdminUser.destroy_all
Size.destroy_all

ADMINS = YAML.load_file('config/admin.yml')['admins']
SIZES = %w( - 80x190 80x200 90x190 90x200 120x190 120x195 120x200 140x190 140x195
            140x200 150x200 158x198 160x190 160x195 160x200 180x200 ).freeze

ADMINS.each do |login, password|
  AdminUser.create!(email: login, password: password, password_confirmation: password)
end

SIZES.each do |size|
  Size.create!(value: size)
end
