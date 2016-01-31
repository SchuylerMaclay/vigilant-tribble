class User < ActiveRecord::Base
   validates :name, length: { minimum: 3 }
   validates :name, uniqueness: true
end
