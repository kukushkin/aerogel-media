fancybox_options =
    padding: 0
    openSpeed: 100
    closeSpeed: 50
    helpers:
        title:
            type: 'outside'


# Opens fancybox attached to <A HREF=...> tag specified by +el+ element .
#
fancybox_open_a_href = (el) ->
    href = $(el).attr 'href'
    title = $(el).attr 'title'
    $.fancybox.open([{ href: href, title: title }], fancybox_options )
    console?.log "** fancybox: called handler on A HREF:#{href}, title:#{title}"

# Opens fancybox attached to <IMG SRC=...> tag specified by +el+ element .
#
fancybox_open_img_src = (el) ->
    href = $(el).attr 'src'
    title = $(el).attr 'title'
    $.fancybox.open([{ href: href, title: title }], fancybox_options )
    console?.log "** fancybox: called handler on IMG SRC title:#{title}"

$ ->
    $("body").on 'click', "A.fancybox", (e) ->
        fancybox_open_a_href this
        e.preventDefault()
    $("body").on 'click', "IMG.fancybox", (e) ->
        fancybox_open_img_src this
        e.preventDefault()
    $("body").on 'mouseenter', "IMG.fancybox", (e) ->
        $(this).css('cursor', 'pointer')

    console?.log "** fancybox: event handlers installed"