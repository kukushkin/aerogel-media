# Renders an IMG tag using given Dragonfly job:
#
#  <%= image_tag @user.avatar.thumb('100x100') %> # => <img src="..." width="..." height="..." .../>
#
def image_tag( src, opts = {} )
  tag :img, { src: src.url, width: src.width, height: src.height }.merge(opts)
end