class Tag < ApplicationRecord
  has_and_belongs_to_many :posts

  def self.no_empty
    result = []
    Tag.all.each do |t|
      result << t if t.posts.count != 0
    end
    return result
  end
end
