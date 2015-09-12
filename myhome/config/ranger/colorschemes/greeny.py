# Copyright (C) 2009-2013  Roman Zimbelmann <hut@lavabit.com>
# This software is distributed under the terms of the GNU GPL version 3.

"""
The delfault colorscheme, slightly edited.

Mainly change statusline colors, and add background color to selection.
"""

from ranger.gui.colorscheme import ColorScheme
from ranger.gui.color import *
import curses

class Default(ColorScheme):
    progress_bar_color = blue

    def use(self, context):
        fg, bg, attr = default_colors

        if context.reset:
            return default_colors

        elif context.in_browser:
            if context.selected:
                attr = reverse
            else:
                attr = normal
            if context.empty or context.error:
                bg = red
            if context.border:
                fg = default
            if context.media:
                if context.image:
                    fg = yellow
                elif context.audio:
                    fg = cyan
                else:
                    fg = magenta
            elif context.container:
                fg = red
            if context.directory:
                attr |= bold
                fg = blue
            elif context.executable and not \
                    any((context.media, context.container,
                        context.fifo, context.socket)):
                attr |= bold
                fg = green
            if context.socket:
                fg = magenta
                attr |= bold
            elif context.fifo or context.device:
                fg = yellow
                if context.device:
                    attr |= bold
            elif context.link:
                if curses.COLORS < 256:
                    fg = context.good and cyan or magenta
                else:
                    fg = context.good and 240 or magenta
            if context.tag_marker and not context.selected:
                fg = yellow
            if not context.selected and (context.cut or context.copied):
                fg = black
                attr |= bold
            if context.main_column:
                if context.selected:
                    attr |= bold
                if context.marked:
                    attr |= bold
                    fg = yellow
            if context.badinfo:
                if attr & reverse:
                    bg = magenta
                else:
                    fg = magenta

            if context.vcsfile and not context.selected:
                attr &= ~bold
                if context.vcsconflict:
                    fg = magenta
                elif context.vcschanged:
                    fg = red
                elif context.vcsunknown:
                    fg = red
                elif context.vcsstaged:
                    fg = green
                elif context.vcssync:
                    fg = green
                elif context.vcsignored:
                    fg = default
            elif context.vcsremote and not context.selected:
                attr &= ~bold
                if context.vcssync:
                    fg = green
                elif context.vcsbehind:
                    fg = red
                elif context.vcsahead:
                    fg = blue
                elif context.vcsdiverged:
                    fg = magenta
                elif context.vcsunknown:
                    fg = red

            if curses.COLORS >= 256:
                if context.tag_marker:
                    if attr & bold:
                        attr -= bold
                        if context.selected:
                            fg += 8
                if context.main_column and context.marked:
                    fg = 119
                    if not context.selected:
                        bg = 234
                        if attr & bold:
                            attr -= bold

        elif context.in_titlebar:
            if curses.COLORS >= 256:
                fg = 119
                bg = 233
            attr |= bold
            if context.hostname:
                fg = context.bad and red or green
            elif context.directory:
                fg = blue
            elif context.tab:
                if context.good:
                    attr |= reverse
            elif context.link:
                fg = cyan

        elif context.in_statusbar:
            if curses.COLORS >= 256:
                fg = 119
                bg = 233
            if context.permissions:
                if context.good:
                    fg = cyan
                elif context.bad:
                    fg = magenta
            if context.marked:
                attr |= bold | reverse
                fg = yellow
            if context.message:
                if context.bad:
                    attr |= bold
                    fg = red
            if context.loaded:
                bg = self.progress_bar_color
            if context.vcsinfo:
                fg = blue
                attr &= ~bold
            if context.vcscommit:
                fg = yellow
                attr &= ~bold

        elif context.in_pager or context.help_markup:
            if context.seperator:
                fg = red
            elif context.link:
                fg = cyan
            elif context.bars:
                fg = black
                attr |= bold
            elif context.key:
                fg = green
            elif context.special:
                fg = cyan
            elif context.title:
                attr |= bold

        if context.text:
            if context.highlight:
                attr |= reverse

        if context.in_taskview:
            if context.title:
                fg = blue

            if context.selected:
                attr |= reverse

            if context.loaded:
                if context.selected:
                    fg = self.progress_bar_color
                else:
                    bg = self.progress_bar_color

        return fg, bg, attr
