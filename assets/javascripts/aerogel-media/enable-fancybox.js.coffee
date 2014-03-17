fancybox_open = (e) ->
    href = $(e).attr 'attr'
    title = $(e).attr 'title'
    $.fancybox.open([{ href: href, title: title }], { padding: 0 })
    console?.log "** fancybox: called handler on #{e}"

$ ->
    $(".fancybox").fancybox
        padding: 0
        openSpeed: 100
        closeSpeed: 50
        helpers:
            title:
                type: 'outside'
    console?.log "** fancybox: event handlers installed"