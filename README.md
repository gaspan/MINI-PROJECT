# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version
 ruby 2.6.5p114 (2019-10-01 revision 67812) [x86_64-linux]

* Database version
 10.4.8-MariaDB

* Ruby on Rails
 Rails 6.0.4.1

* Configuration
open folder config > database.yml
change value from
```
  username: root
  password:
  socket: /opt/lampp/var/mysql/mysql.sock
  ``` 
  according to the installed mysql authentication

* Database creation
Create database wich name are "BackendMiniProject_development" , "BackendMiniProject_test" , "BackendMiniProject_production"

* Database initialization

* How to run the test suite
type this command in terminal inside this root folder of application
```rake db:migrate```
then
```rake db:seed```
run this command to run this application
```rails s```

* API 
1. Users can send a message to another user
```
POST /send_message HTTP/1.1
Host: 127.0.0.1:3000
Content-Type: application/json
Content-Length: 68

{
	"user_id_sender":"1",
	"user_id_reciver":"3",
	"text":"Hallo"
	
} 
```
2. Users can list all messages in a conversation between them and another user.
```
GET /message/1 HTTP/1.1
Host: 127.0.0.1:3000
Content-Type: application/json
Content-Length: 23

{
	"my_user_id":"1"
	
}
```
3. Users can reply to a conversation they are involved with.
```
POST /reply_message HTTP/1.1
Host: 127.0.0.1:3000
Content-Type: application/json
Content-Length: 90

{
    "room_id" : "1",
	"user_id_sender":"2",
	"user_id_reciver":"1",
	"text":"sehat?"
	
}
```
4. User can list all their conversations
```
GET /list_message_user/1 HTTP/1.1
Host: 127.0.0.1:3000
```
or you can import this collection to your postman ```https://www.getpostman.com/collections/4610bae82a915a86ba8d```
in postman: click import, click tab link paste url above to text box, then click continue
