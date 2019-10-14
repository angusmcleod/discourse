# frozen_string_literal: true

class DirectoryItemSerializer < ApplicationSerializer
  attributes :id,
             :time_read

  has_one :user, embed: :objects, serializer: DirectoryItemUserSerializer
  attributes *DirectoryItem.headings

  def id
    object.user_id
  end

  def time_read
    object.user_stat.time_read
  end

  def include_time_read?
    object.period_type == DirectoryItem.period_types[:all]
  end

end
