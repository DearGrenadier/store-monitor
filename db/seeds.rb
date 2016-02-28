AdminUser.destroy_all

AdminUser.create(email: 'admin@nazarchuk.tk', password: 'password', password_confirmation: 'password')

Size.destroy_all

%w(- 80x190 80x200 90x190 90x200 120x190 120x195 120x200 140x190 140x195 140x200 150x200 158x198 160x190 160x195 160x200 180x200).each do |size|
  Size.create(value: size)
end
