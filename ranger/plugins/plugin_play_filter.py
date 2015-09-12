# Compatible since ranger 1.7.0 (git commit c82a8a76989c)
#
# Hide the not-to-see files in my anime directory unless hidden files are shown
# (only the files/directories marked with a certain tag are shown by default).

import ranger.api
old_hook_init = ranger.api.hook_init

def hook_init(fm):
    from os.path import dirname, basename
    import ranger.container.directory
    old_accept_file = ranger.container.directory.accept_file

    SHOWN_TAGS = '>'
    DIRS = ('animes',)

    def is_in_dirs(file):
        return basename(dirname(file.path)) in DIRS

    def must_be_hidden(file):
        tag = fm.tags.tags.get(file.path)
        return tag is None or tag not in SHOWN_TAGS

    def custom_accept_file(file, filters):
        if (not file.fm.settings.show_hidden) and is_in_dirs(file) and must_be_hidden(file):
            return False
        else:
            return old_accept_file(file, filters)

    try:
        ranger.container.directory.accept_file = custom_accept_file
    finally:
        old_hook_init(fm)

ranger.api.hook_init = hook_init
