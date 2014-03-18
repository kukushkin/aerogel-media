# Enables smart-file-input widget on element, specified by +widget+
#
# Suggested markup:
#
# <div class="smart-file-input">
#
#   <input type="file" name="..."/>
#   <input class="file-remove-field" type="..." name="..."/>
#
#   <div class="file-empty">
#      ...no file selected...
#      <button class="btn-file-select">Choose file...</button>
#   </div>
#
#   <div class="file-exists">
#     <div class="file-old">
#       ...previously uploaded file...
#     </div>
#     <div class="file-new">
#       ...preview or name for selected file...
#     </div>
#     <button class="btn-file-change">Change</button>
#     <button class="btn-file-remove">Remove</button>
#   </div>
#
# </div>
#
smart_file_input = (widget) ->
    widget.addClass "smart-file-input-applied"
    input_tag = widget.find 'input[type=file]'
    input_remove_tag = widget.find 'input.file-remove-field'
    btn_select = widget.find '.btn-file-select'
    btn_change = widget.find '.btn-file-change'
    btn_remove = widget.find '.btn-file-remove'
    el_file_empty = widget.find '.file-empty'
    el_file_exists = widget.find '.file-exists'
    el_file_exists_old = widget.find '.file-old'
    has_old_file = el_file_exists_old.length > 0
    el_file_exists_new = widget.find '.file-new'
    input_tag.hide()
    el_file_exists_new.hide()
    if has_old_file
        el_file_empty.hide()
    else
        el_file_exists.hide()
    btn_select.on 'click', (e) ->
        e.preventDefault()
        input_tag.trigger 'click'
    btn_change.on 'click', (e) ->
        e.preventDefault()
        input_tag.trigger 'click'
    btn_remove.on 'click', (e) ->
        e.preventDefault()
        on_file_remove()
    input_tag.on 'change', (e) ->
        numFiles = ( if input_tag.get(0).files then input_tag.get(0).files.length else 1 )
        file = input_tag.get(0).files[0] if numFiles > 0
        re = new RegExp '\\\\', 'g'
        label = input_tag.val().replace(re, '/').replace(/.*\//, '')
        console?.log "** smart-file-input: selected #{numFiles}, '#{label}'"
        if numFiles
            # file selected, show new file
            on_file_selected( file, numFiles, label )
        else
            # file selection cancelled, show previous state
            on_file_cancelled()

    on_file_remove = ->
        el_file_empty.show()
        el_file_exists.hide()
        has_old_file = false
        input_remove_tag.val('1')
        input_tag_reset()
        console?.log "** smart-file-input: remove file, selected or old"

    on_file_selected = ( file, num, label ) ->
        input_remove_tag.val('') # cancel remove
        el_file_empty.hide()
        el_file_exists_old.hide() # if has_old_file
        el_file_exists_new.find('.file-label').text label
        show_file_preview file, label
        el_file_exists_new.show()
        el_file_exists.show()

    on_file_cancelled = ->
        if has_old_file
            # file selection cancelled, show old file
            el_file_empty.hide()
            el_file_exists_old.show()
            el_file_exists_new.hide()
            el_file_exists.show()
        else
            # file selection cancelled, no old file
            input_remove_tag.val('1') # re-enable remove
            el_file_empty.show()
            el_file_exists.hide()

    input_tag_reset = ->
        input_tag.wrap('<form>').parent('form').trigger('reset')
        input_tag.unwrap()

    show_file_preview = (file, label) ->
        file_ext = file.name.split('.')[-1..][0] if file.name?
        el_file_preview = el_file_exists_new.find '.file-preview'
        if ( el_file_preview.length &&
            file.type? && file.type.match('image.*') &&
            file_ext? && file_ext.match(/^(gif|png|jpe?g)$/i) &&
            FileReader?
        )
            reader = new FileReader()
            reader.onload = (e) ->
                el_file_preview.get(0).src = e.target.result
            reader.readAsDataURL file
            el_file_preview.attr 'title', label
            el_file_preview.show()
            console?.log "** smart-file-input: show file preview"
        else
            el_file_preview.hide()
            console?.log "** smart-file-input: hide file preview"

    console?.log "** smart-file-input: applied to element"


# Apply on ready
$ ->
    $(".smart-file-input:not(.smart-file-input-applied)").each ->
        smart_file_input $(this)
    console?.log "** smart-file-input: loaded"

