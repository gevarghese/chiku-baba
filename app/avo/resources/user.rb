
    class Avo::Resources::User < Avo::BaseResource  # Change User to UserResource
            self.model_class = ::User  # Add this line
      # self.includes = []
      # self.attachments = []
      # self.search = {
      #   query: -> { query.ransack(id_eq: q, m: "or").result(distinct: false) }
      # }

      def fields
        field :id, as: :id
        field :email, as: :text
        field :sign_in_count, as: :number
        field :current_sign_in_at, as: :date_time
        field :last_sign_in_at, as: :date_time
        field :current_sign_in_ip, as: :text
        field :last_sign_in_ip, as: :text
        field :confirmation_token, as: :text
        field :confirmed_at, as: :date_time
        field :confirmation_sent_at, as: :date_time
        field :unconfirmed_email, as: :text
        field :failed_attempts, as: :number
        field :unlock_token, as: :text
        field :locked_at, as: :date_time
        field :first_name, as: :text
        field :last_name, as: :text
        field :role, as: :select, enum: ::User.roles
        field :avatar, as: :file
        field :blogs, as: :has_many
        field :comments, as: :has_many
      end
    end
