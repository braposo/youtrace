# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  FLASH_NOTICE_KEYS = [:error, :notice, :warning]

  def flash_messages
    return unless messages = flash.keys.select{|k| FLASH_NOTICE_KEYS.include?(k)}
    formatted_messages = messages.map do |type|      
      content_tag :div, :id => type.to_s do
        message_for_item(flash[type], flash["#{type}_item".to_sym])
      end
    end
    formatted_messages.join
  end

  def message_for_item(message, item = nil)
    if item.is_a?(Array)
      message % link_to(*item)
    else
      message % item
    end
  end
  
  def in_controller?(controller, name)
    controller.controller_name == name
  end
  
  def in_action?(controller, name)
    controller.action_name == name
  end
  
  def photo_or_gravatar_for(user, options={})
    default = {:class => 'photo', :size => '100', :alt => 'avatar'}
    if !user.photo.nil?
      options = default.merge(options)
      "<img class=\"#{options[:class]}\" alt=\"#{options[:alt]}\" width=\"#{options[:size]}\" height=\"#{options[:size]}\" src=\"#{user.photo}\" />"
    else
      gravatar(user.email, options)
    end
  end
  
  def photo_or_default_for(group, options={})
    default = {:class => 'photo', :size => '100', :alt => 'avatar'}
    options = default.merge(options)
    if !group.photo.empty?
      "<img class=\"#{options[:class]}\" alt=\"#{options[:alt]}\" width=\"#{options[:size]}\" height=\"#{options[:size]}\" src=\"#{group.photo}\" />"
    else
      "<img class=\"#{options[:class]}\" alt=\"#{options[:alt]}\" width=\"#{options[:size]}\" height=\"#{options[:size]}\" src=\"#{image_path('groups/default.png')}\" />"
    end
  end
end
