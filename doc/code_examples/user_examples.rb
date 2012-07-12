
user = User.create(username: "mhack", first_name: "Marcos")
user.password = "abdcd"
user.update_attributes(last_name: "Hack", password: "12345")
user.last_name #=> "Hack"
user.passwor   #=> "abdcd"

