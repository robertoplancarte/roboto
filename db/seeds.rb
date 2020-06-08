# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
user = User.create(email: 'admin@test.com', password: '1234567890', password_confirmation: '1234567890', name: 'Roberto Plancarte')
user.admin = true
user.save!
puts user.errors.inspect

user = User.create(email: 'developer@test.com', password: '1234567890', password_confirmation: '1234567890', name: 'Guillermo Romero')
user.developer = true
user.save!

user = User.create(email: 'tester@test.com', password: '1234567890', password_confirmation: '1234567890', name: 'Aaron Aycock')
user.tester = true
user.save!

user = User.create(email: 'supporter@test.com', password: '1234567890', password_confirmation: '1234567890')
user.supporter = true
user.save!

environment = Environment.create(name: 'development',
                                 private_key_path: '/home/robertoplancarte/.ssh/keys/local',
                                 fqdn: 'localhost',
                                 user_name: 'robertoplancarte')


environment = Environment.create(name: 'production',
                                 private_key_path: '/home/robertoplancarte/.ssh/keys/local',
                                 fqdn: 'localhost',
                                 user_name: 'robertoplancarte')

script = Script.create(title: 'test',
                       code: 'puts Environment.find_by(name: ARGV[0]).id',
                       path_to_application: '/home/robertoplancarte/prometheus',
                       command: '/home/robertoplancarte/.rbenv/shims/rails runner')


script1 = Script.create(title: 'test1',
                        code: '',
                        path_to_application: '/home/robertoplancarte/prometheus',
                        command: 'pwd')

Execution.create(input: 'development', user: user, environment: environment, script: script)
Execution.create(input: 'development', user: user, environment: environment, script: script1)
