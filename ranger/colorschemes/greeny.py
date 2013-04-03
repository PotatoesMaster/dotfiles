# Copyright (C) 2009, 2010  Roman Zimbelmann <romanz@lavabit.com>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

"""
The delfault88 colorscheme, slightly edited.

Mainly change statusline colors, and add background color to selection.
There is no color for progress bar.
"""

from ranger.gui.color import *
from ranger.colorschemes.default import Default
import curses

class Scheme(Default):
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

		elif context.in_titlebar:
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

		if context.in_pager or context.help_markup:
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

		if curses.COLORS < 256:
			return fg, bg, attr

		if context.in_browser:
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

		return fg, bg, attr

