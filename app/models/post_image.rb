class PostImage < ApplicationRecord
	belong_to :user
	attachment :image
end
