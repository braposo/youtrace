module GroupsHelper
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
