class Hit < ApplicationRecord
  belongs_to :link

  validates_presence_of :ip
end
