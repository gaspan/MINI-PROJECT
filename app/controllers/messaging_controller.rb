class MessagingController < ApplicationController
    def send_message

        @room = Room.new()
        if @room.save
            @user_chat_sender = Userchat.new(:room_id => @room.id, :user_id => params[:user_id_sender])
            @user_chat_receiver = Userchat.new(:room_id => @room.id, :user_id => params[:user_id_reciver])
            @message = Message.new(:text => params[:text], :room_id => @room.id, :user_id => params[:user_id_sender] )
            @user_room_read = Userroomread.create(:room_id => @room.id, :user_id => params[:user_id_reciver], :unread => 1 )
            @user_room_read = Userroomread.create(:room_id => @room.id, :user_id => params[:user_id_sender], :unread => 0 )
            if @message.save && @user_chat_sender.save && @user_chat_receiver.save
                render json:{
                    values: "",
                    message:"Success!"
                },status:201 

            else
                render json:{
                    values:{},
                    message:"Failed!"
                },status:200
            end
        else
            render json:{
                values:{},
                message:"Failed!"
            },status:200
        end

        


    end

    def show_message_with_another_user_by_room_id
        @messages = Message.select('messages.id', 'messages.id AS message_id', 'messages.text', 'messages.room_id', 'messages.user_id', 'messages.created_at', 'users.name').where({:room_id => params[:room_id]}).joins("LEFT JOIN users ON users.id = messages.user_id").order(:created_at)

        if @messages.present?

            @user_room_read = Userroomread.where(room_id: params[:room_id], user_id: params[:my_user_id] )            
            if @user_room_read.present?
                @user_room_read_updt = Userroomread.find_by(room_id: params[:room_id], user_id: params[:my_user_id] )
                @user_room_read_updt.update({unread: 0 })

                
            else
                @user_room_read = Userroomread.create(room_id: params[:room_id], user_id: params[:my_user_id], unread: 0 )
                
            end

            render json:{
                values: @messages,
                message: 'Success!'
            }, status:200
        else
            render json:{
                values:"",
                message:"we can't found any data!"
            }, status:400
        end
        
    end

    def reply_conversation_by_room

        # check user in room
        @userchat = Userchat.where( room_id: params[:room_id], user_id: params[:user_id_sender] )

        if @userchat.present?
            @message = Message.new(:text => params[:text], :room_id => params[:room_id], :user_id => params[:user_id_sender] )

            @user_room_read = Userroomread.where(room_id: params[:room_id], user_id: params[:user_id_reciver] )
            if @user_room_read.present?
                @user_room_read_updt = Userroomread.find_by(room_id: params[:room_id], user_id: params[:user_id_reciver] )
                @user_room_read_updt.update({unread: @user_room_read.unread + 1 })
            else
                @user_room_read = Userroomread.create(:room_id => params[:room_id], :user_id => params[:user_id_reciver], :unread => 1 )
                @user_room_read = Userroomread.create(:room_id => params[:room_id], :user_id => params[:user_id_sender], :unread => 0 )
            end

            if @message.save
                render json:{
                    values: "",
                    message:"Success!"
                },status:201 

            else
                render json:{
                    values:{},
                    message:"Failed!"
                },status:200
            end
        else
            render json:{
                values:"",
                message:"kamu tidak masuk dalam room ini"
            }, status:400
        end

    end

    def list_conversation_by_user
        @messages = Userchat.select("room_id","id")
        .where( "userchats.user_id = " + params[:my_user_id] )

        if @messages.present?

            @list_message = []
            @messages.each do |item|
                @one_message = Message.where(room_id: item[:room_id]).order(created_at: :desc)
                .select('messages.id', 'messages.id AS message_id', 'messages.text', 'messages.room_id', 'messages.user_id', 'messages.created_at', 'users.name', 'userroomreads.unread')
                .joins("LEFT JOIN userroomreads ON userroomreads.user_id = " + params[:my_user_id] + " AND userroomreads.room_id =  messages.room_id " )
                .joins("LEFT JOIN users ON users.id = messages.user_id")
                .limit(1)
                @list_message.push(@one_message)

            end
            
            render json:{
                values: @list_message,
                message: 'Success!'
            }, status:200
        else
            render json:{
                values:"",
                message:"we can't found any data!"
            }, status:400
        end
        
    end
    
    
    
end
