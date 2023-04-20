module TransactionManager
    class TransactionAlert < ApplicationService
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
            if @transaction.status == "failed"
                generate_failed_notification
            elsif @transaction.transaction_type == 'topup'
                generate_topup_notification
            else
                generate_sender_notification
                generate_receiver_notification
            end
            
        end

        def generate_failed_notification
            balance = @transaction.transaction_type == 'topup' ? @recipient_balance : @sender_balance
            notification = Notification.new(
                message: "Your transaction of KES #{@transaction.amount} to #{@recipient_user.surname} failed due to #{@transaction.status_description}, Your account balance is KES #{balance}",
                recipient: @sender_user.mobile,
                scheduled: false,
                notification_type: "sms",
                datetime: DateTime.current,
            )
            if notification.save
                SendMessageJob.perform_later(notification)
            end
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
        def generate_topup_notification
            notification = Notification.new(
                message: "Your topup of KES #{@transaction.amount} was completed successfully, Your new account balance is KES #{@recipient_balance}",
                recipient: @recipient_user.mobile,
                scheduled: false,
                notification_type: "sms",
                datetime: DateTime.current,
            )
            if notification.save
                SendMessageJob.perform_later(notification)
            end
        end

    end
end