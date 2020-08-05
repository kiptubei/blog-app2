class Article < ApplicationRecord
  has_many :comments
  has_many :taggings
  has_many :tags, through: :taggings

  def tag_list
    tags.collect(&:name).join(', ')
  end

  def tag_list=(tags_string)
    tag_name = tags_string.split(',').collect do |s|
      s.strip.downcase
    end.uniq

    new_or_found_tags = tag_name.collect { Tag.find_or_create_by(name: tag_name) }
    self.tags = new_or_found_tags
  end
end
