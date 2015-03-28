module Authentication
  def login user, password = 'login'
    user.update_attribute :password, password
    page.driver.post login_path, {name: user.name, password: password}
  end
end
