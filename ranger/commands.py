from ranger.api.commands import *

# download
from ranger.ext.shell_escape import shell_quote

# atool (compress, compressyanked, extractthere)
from ranger.core.loader import CommandLoader

# hash_to_bookmarks
from ranger.ext.spawn import spawn
from ranger.fsobject import Directory
import re

class download(Command):
    """
    :download [filename]

    Download uri in X clipboard using wget
    """

    def execute(self):
        command = 'wget --content-disposition --trust-server-names "`xsel -o`"'
        if self.rest(1):
            command += ' -O ' + shell_quote(self.rest(1))
        action = ['zsh', '-c', command]
        self.fm.execute_command(action)


class grep(Command):
    """
    :grep <string>

    Look for a string in all marked files or directories
    """

    command=['grep', '--color=always', '-rnIe']

    def execute(self):
        if self.rest(1):
            action = self.command[:]
            action.extend([self.rest(1)])
            action.extend(f.path for f in self.fm.env.get_selection())
            self.fm.execute_command(action, flags='p')

class grepi(grep):
    command=['grep', '--color=always', '-rinIe']

class grap(grep):
    command=['grap', '--color=always', '-rnIe']

class grapi(grep):
    command=['grap', '--color=always', '-rinIe']


class locate(Command):
    """
    :locate <name_part>

    Search in current directory and subdirs for a file whose name contains the
    given string (case insensitive) and prompt for the one to select in ranger
    using slmenu (press escape 2 times to cancel).
    """
    def execute(self):
        import subprocess
        from ranger.core.loader import safeDecode
        import sys
        import os.path

        if self.rest(1):
            command = 'find . -iname ' + shell_quote('*' + self.rest(1) + '*') + \
                    '| slmenu -t -i -l $(($(tput lines)-1)) -p locate '
            self.fm.ui.suspend()
            try:
                p = subprocess.Popen(command, shell=True, stdout=subprocess.PIPE)
                filename = p.communicate()[0]
            finally:
                self.fm.ui.initialize()
            if p.poll() == 0: # no error returned
                if sys.version >= '3':
                    filename = safeDecode(filename)
                # remove the newline
                filename = filename.rstrip('\n')
                # make the path absolute
                filename = os.path.join(self.fm.thisdir.path, filename.lstrip('./'))
                # select the file
                self.fm.select_file(filename)
        else:
            self.fm.notify('usage: locate <name_part>', bad=True)


class findfile(Command):
    """
    :findfile <pattern>

    Look for a file named according to pattern in current dir and its subdirs
    """
    def execute(self):
        if self.rest(1):
            command = 'find . -iname ' + shell_quote('*' + self.rest(1) + '*') + '| grep -i --color=always ' + shell_quote(self.rest(1))
            action = ['zsh', '-c', command]
            self.fm.execute_command(action, flags='p')


class hash_to_bookmarks(Command):
    def tab(self):
        return ['hash_to_bookmarks force']

    def execute(self):
        lastword = self.arg(-1)
        force = lastword == 'force'
        hash_pattern = re.compile(r'^[\d\w]=.')
        entries = spawn('zsh', '-ic', 'hash -d')

        self.fm.bookmarks.update_if_outdated()

        for i in entries.split('\n'):
            if hash_pattern.match(i):
                key, value = i[0], i[2:]
                if force or not key in self.fm.bookmarks.dct.keys():
                    self.fm.bookmarks[key] = Directory(value)


class trash(Command):
    """
    :trash

    Send the selection to trash.

    "Selection" is defined as all the "marked files" (by default, you
    can mark files with space or v). If there are no marked files,
    use the "current file" (where the cursor is)

    When attempting to trash non-empty directories or multiple
    marked files, it will require a confirmation.
    """

    allow_abbrev = False

    def trash(self):
        cwd = self.fm.thisdir
        cf = self.fm.thisfile

        # delete empty directories directly
        if not cwd.marked_items and (cf.is_directory and not cf.is_link \
                and len(os.listdir(cf.path)) == 0):
            self.fm.delete()
        else: # else move to trash
            files = [f.path for f in self.fm.thistab.get_selection()]
            self.fm.execute_command(['mv', '--backup=numbered'] \
                + files + ['/home/tharek/.trash'])
            self.fm.tag_remove(paths=files)

    def execute(self):
        import os
        if self.rest(1):
            self.fm.notify("Error: trash takes no arguments! It trashes "
                    "the selected file(s).", bad=True)
            return

        cwd = self.fm.thisdir
        cf = self.fm.thisfile
        if not cwd or not cf:
            self.fm.notify("Error: no file selected for deletion!", bad=True)
            return

        # Use the same confirmation setting than the delete command
        confirm = self.fm.settings.confirm_on_delete
        many_files = (cwd.marked_items or (cf.is_directory and not cf.is_link \
                and len(os.listdir(cf.path)) > 0))

        if confirm != 'never' and (confirm != 'multiple' or many_files):
            self.fm.ui.console.ask("Confirm trashing of: %s (y/N)" %
                ', '.join(f.basename for f in self.fm.thistab.get_selection()),
                self._question_callback, ('n', 'N', 'y', 'Y'))
        else:
            # no need for a confirmation, just trash
            self.trash()

    def _question_callback(self, answer):
        if answer == 'y' or answer == 'Y':
            self.trash()


class pasta(Command):
    """
    :pasta <filename>

    Paste the X selection as a new file.
    """

    def execute(self):
        from os.path import join, expanduser

        filename = join(self.fm.env.cwd.path, expanduser(self.rest(1)))
        self.fm.execute_command('xsel -o > "' + filename + '"')


class md(Command):
    """
    :md <dirname>

    Creates a directory with the name <dirname> and cd to it.
    """

    def execute(self):
        from os.path import join, lexists
        from os import makedirs

        dirname = join(self.fm.env.cwd.path, self.rest(1))
        if not lexists(dirname):
            makedirs(dirname)
        self.fm.thisdir.load_content(schedule=False)
        self.fm.select_file(dirname)
        self.fm.cd(dirname)


class mds(Command):
    """
    :mds <dirname1> [dirname2 dirname3... ]

    Creates multiple directories (space separated)
    """

    def execute(self):
        from os.path import join, lexists
        from os import makedirs

        for dirname in self.args[1:]:
            dirpath = join(self.fm.env.cwd.path, dirname)
            if not lexists(dirpath):
                makedirs(dirpath)


class diff(Command):
    # vimdiff selected files
    def execute(self):
        self.fm.execute_console('shell vimdiff %s')


class diffyanked(Command):
    # vimdiff yanked files
    def execute(self):
        self.fm.execute_command(['vimdiff'] + [f.path for f in self.fm.env.copy])


class feh(Command):
    def execute(self):
        if self.quantifier == 1:
            fehcmd = 'feh -T scan'
        elif self.quantifier == 2:
            fehcmd = 'feh -T magick'
        elif self.quantifier == 3:
            fehcmd = 'feh -T thumbs'
        else:
            fehcmd = 'feh'

        self.fm.execute_command(r"""ls -A | grep -Ei '^*.(jpeg|psd|svg|jpg|png|gif|bmp|xpm|tga)$' | sed "s/^/'/;s/\$/'/" | xargs """ +
                fehcmd, flags='d')


class compress(Command):
    def execute(self):
        """ Compress marked files to current directory """
        cwd = self.fm.env.cwd
        marked_files = cwd.get_selection()

        if not marked_files:
            return

        def refresh(_):
            cwd = self.fm.env.get_directory(original_path)
            cwd.load_content()

        original_path = cwd.path
        dest = self.line[self.line.index(' ')+1:]

        descr = "compressing files in: " + os.path.basename(dest)
        obj = CommandLoader(args=['apack', dest] + \
            [os.path.relpath(f.path, cwd.path) for f in marked_files], descr=descr)

        obj.signal_bind('after', refresh)
        self.fm.loader.add(obj)

    def tab(self):
        """ Complete with current folder name """

        extension = ['.zip', '.tbz', '.tgz', '.7z']
        return [self.line + ext for ext in extension]

class compressyanked(Command):
    def execute(self):
        """ Compress copied files to current directory """
        copied_files = tuple(self.fm.env.copy)

        if not copied_files:
            return

        def refresh(_):
            cwd = self.fm.env.get_directory(original_path)
            cwd.load_content()

        one_file = copied_files[0]
        cwd = self.fm.env.cwd
        original_path = cwd.path
        parts = self.line.split()
        au_flags = parts[1:]

        descr = "compressing files in: " + os.path.basename(parts[1])
        obj = CommandLoader(args=['apack'] + au_flags + \
            [os.path.relpath(f.path, cwd.path) for f in copied_files], descr=descr)

        self.fm.env.copy.clear()
        self.fm.env.cut = False

        obj.signal_bind('after', refresh)
        self.fm.loader.add(obj)

    def tab(self):
        """ Complete with current folder name """

        extension = ['.zip', '.tbz', '.tgz', '.7z']
        return [self.line + ext for ext in extension]

class extractthere(Command):
    def execute(self):
        """ Extract copied files to current directory """
        copied_files = tuple(self.fm.env.copy)

        if not copied_files:
            return

        def refresh(_):
            cwd = self.fm.env.get_directory(original_path)
            cwd.load_content()

        one_file = copied_files[0]
        cwd = self.fm.env.cwd
        original_path = cwd.path
        au_flags = ['-X', cwd.path]
        au_flags += self.line.split()[1:]
        au_flags += ['-e']

        self.fm.env.copy.clear()
        self.fm.env.cut = False
        if len(copied_files) == 1:
            descr = "extracting: " + os.path.basename(one_file.path)
        else:
            descr = "extracting files from: " + os.path.basename(one_file.dirname)
        obj = CommandLoader(args=['aunpack'] + au_flags \
            + [f.path for f in copied_files], descr=descr)

        obj.signal_bind('after', refresh)
        self.fm.loader.add(obj)


class play_anime(Command):
    def execute(self):
        cwd = self.fm.env.cwd
        # select next tagged file
        self.fm.execute_console("search_next order=tag")
        selection = cwd.pointed_obj
        if not selection.is_file or not self.fm.tags.tags.get(selection.path) == '>':
            return
        self.fm.tag_remove(movedown=False)
        if cwd.pointer + 1 == len(cwd.files):
            self.fm.move(left=1)
        else:
            self.fm.tag_toggle(paths=[cwd.files[cwd.pointer + 1].path], tag='>', movedown=True)
        self.fm.execute_file(selection, mode=self.quantifier or 0)

class toggle_play(Command):
    def execute(self):
        cwd = self.fm.env.cwd
        selection = cwd.pointed_obj
        tag = '"'
        if not self.fm.tags.tags.get(selection.path) == '>':
            tag = '>'
        self.fm.tag_toggle(paths=[selection.path], tag=tag, movedown=False)

class store_file(Command):
    "Store current selected file"
    stored = None
    def execute(self):
        cwd = self.fm.env.cwd
        selection = cwd.pointed_obj
        store_file.stored = selection

class copy_as_and_link(Command):
    "Move and rename the stored file and replace it with a symbolic link"
    def execute(self):
        if not store_file.stored:
            return

        cwd = self.fm.env.cwd
        new_name = self.rest(1)

        if not new_name:
            new_name = store_file.stored.basename

        new_path = os.path.join(cwd.path, new_name)
        old_path = store_file.stored.path

        # check file existence
        if os.path.lexists(new_name):
            self.fm.notify('Aborted: ' + new_path + ' already exists!')
            return

        # move
        os.rename(old_path, new_name)
        # replace the old file with a symbolic link
        os.symlink(new_path, old_path)

        # Remove stored file
        store_file.stored = None

    def tab(self):
        if not store_file.stored:
            return

        # complete with stored file name
        return ['copy_as_and_link ' + store_file.stored.basename]

class random(Command):
    def execute(self):
        from random import sample
        nb = int(self.rest(1) or 1)
        cwd = self.fm.env.cwd
        population = cwd.marked_items or cwd.files
        elected = sample(population, nb)
        for i in cwd.files:
            cwd.mark_item(i, val=i in elected)
        self.fm.ui.status.need_redraw = True
        self.fm.ui.need_redraw = True

class paste_rename(Command):
    """Paste copy buffer content, renaming file"""

    def execute(self):
        copied_files = tuple(self.fm.env.copy)

        if not copied_files:
            return

        cwd = self.fm.env.cwd
        new_name = self.rest(1)

        if not new_name:
            return
        # shell cp/mv %c 

        def refresh(_):
            cwd = self.fm.env.get_directory(original_path)
            cwd.load_content()

        original_path = cwd.path
        one_file = copied_files[0]

        cp_flags = ['--backup=numbered', '-a', '--']
        mv_flags = ['--backup=numbered', '--']

        if self.fm.env.cut:
            self.fm.env.copy.clear()
            self.fm.env.cut = False
            if len(copied_files) == 1:
                descr = "moving: " + one_file.path
            else:
                descr = "moving files from: " + one_file.dirname
            obj = CommandLoader(args=['mv'] + mv_flags \
                    + [f.path for f in copied_files] \
                    + [new_name], descr=descr)
        else:
            descr = "copying files from: " + one_file.dirname
            obj = CommandLoader(args=['cp'] + cp_flags \
                    + [f.path for f in copied_files] \
                    + [new_name], descr=descr)

        obj.signal_bind('after', refresh)
        self.fm.loader.add(obj)
