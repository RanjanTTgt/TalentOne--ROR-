class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def encrypted_id
    ApplicationRecord.encrypt(self.id)
  end

  class << self
    def encrypt(str)
      [str.to_s].pack("m").chomp
    end

    def decrypt(str)
      (str.to_s).unpack("m").first.to_i
    end
  end
end
