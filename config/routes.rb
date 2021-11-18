Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  post 'send_message' => 'messaging#send_message'
  get 'message/:room_id' => 'messaging#show_message_with_another_user_by_room_id'
  post 'reply_message' => 'messaging#reply_conversation_by_room'
  get 'list_message_user/:my_user_id' => 'messaging#list_conversation_by_user'



end
