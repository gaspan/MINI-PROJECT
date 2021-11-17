class MessagingController < ApplicationController
    def send_message

        @room_id = params[:room_id]
        if @room_id == ""
            # room blm ada
            @room = Room.new()
            if @room.save
                @user_chat_sender = Userchat.new(:room_id => @room.id, :user_id => params[:user_id_sender])
                @user_chat_receiver = Userchat.new(:room_id => @room.id, :user_id => params[:user_id_reciver])
                @message = Message.new(:text => params[:text], :room_id => @room.id, :user_id => params[:user_id_sender] )
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
        else
            #room sudah ada
            @message = Message.new(:text => params[:text], :room_id => params[:room_id], :user_id => params[:user_id_sender] )
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
            
        end

        


    end
end
