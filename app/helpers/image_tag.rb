# Renders an IMG tag using given Dragonfly job:
#
#  <%= image_tag @user.avatar.thumb('100x100') %> # => <img src="..." width="..." height="..." .../>
#
def image_tag( src, opts = {} )
  if ( src.try(:image?) rescue false )
    tag :img, { src: src.url, width: src.width, height: src.height }.merge(opts)
  else
    h "<not an image!>"
  end
end


# Renders an IMG for a given +thumb+ enclosed in A.fancybox
#
#  <%= image_thumb_tag @user.avatar, '100x100' %>
#
def image_thumb_tag( src, thumb, opts = {} )
  if ( src.try(:image?) rescue false )
    tag :a, { href: src.url, class: 'fancybox', title: src.description }.merge(opts) do
      image_tag src.thumb(thumb)
    end
  else
    h "<not an image!>"
  end
end