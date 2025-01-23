# Criação de um administrador
admin = User.find_or_create_by!(email: 'admin@admin.com') do |user|
    user.password = 'admin123' # Substitua por uma senha segura
    user.password_confirmation = 'admin123'
    user.role = 'admin'
  end
  puts "Administrador criado: #{admin.email}"
  
  # Criação de um usuário padrão
  user = User.find_or_create_by!(email: 'user@user.com') do |user|
    user.password = 'user123' # Substitua por uma senha segura
    user.password_confirmation = 'user123'
    user.role = 'user'
  end
  puts "Usuário padrão criado: #{user.email}"
  