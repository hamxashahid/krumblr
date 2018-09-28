module ApplicationHelper
  def universal_tag_list
    ActsAsTaggableOn::Tag.most_used
  end
end
