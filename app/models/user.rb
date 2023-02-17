class User < ApplicationRecord
    has_one_attached :header_image
    attr_accessor :password

    validates :first_name, presence: true
    validates :mobile, length: { is: 10 }
    validates :email, uniqueness: true, length: {in: 5..50}
    validates :password, presence: true, confirmation: true, length: {in: 5..17}, on: :create

    before_save :encrypt_new_password

    def self.authenticate(email, password)
        user = find_by_email(email)
        if user && user.authenticated_password(password)
            return user
        end
    end
    
    def authenticated_password(password)
        self.encrypted_password == encrypt(password)
    end

    def self.create_random_password
        (0...8).map { (65 + rand(26)).chr }.join
    end

    protected


    def encrypt_new_password
        return if password.blank?
        self.encrypted_password = encrypt(password)
    end

    def encrypt(string)
        Digest::SHA1.hexdigest(string)
    end


end
