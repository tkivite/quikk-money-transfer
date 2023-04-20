module TransactionManager
    class TranscationAlert < ApplicationService
        attr_reader :transaction
  
        def initialize(transaction)
            @transaction = transaction
            @recipient_user = @transaction.recipient.user
            @recipient_balance = @transaction.recipient.balance

            @sender_user = @transaction.sender.user
            @sender_balance = @transaction.sender.balance

            # @transaction
        end

        def call
            
            
        end
        def generate_sender_notification
            notification = Notification.new(
                message: "Your transfer of KES #{@transaction.amount} to #{@recipient_user.surname} has been completed successfully, Your new account balance is KES #{@sender_balance}",
                recipient: @sender_user.mobile,
                scheduled: false,
                notification_type: "sms",
                datetime: DateTime.current,
            )
            if notification.save
                SendMessageJob.perform_later(notification)
            end
        end

        def generate_receiver_notification
            notification = Notification.new(
                message: "Your have received KES #{@transaction.amount} from #{@sender_user.surname}, Your new account balance is KES #{@recipient_balance}",
                recipient: @recipient_user.mobile,
                scheduled: false,
                notification_type: "sms",
                datetime: DateTime.current,
            )
            if notification.save
                SendMessageJob.perform_later(notification)
            end
        end

        def generate_receiver_notification
            notification = Notification.new(
                message: "Your ",
                recipient: params[:recipient],
                scheduled: params[:scheduled],
                notification_type: params[:notification_type],
                datetime: params[:datetime],
            )
            if notification.save
                SendMessageJob.perform_later(notification)
            end
        end

        def generate_topup_notification
            notification = Notification.new(
                message: "Your ",
                recipient: params[:recipient],
                scheduled: params[:scheduled],
                notification_type: params[:notification_type],
                datetime: params[:datetime],
            )
            if notification.save
                SendMessageJob.perform_later(notification)
            end
        end

    end
end