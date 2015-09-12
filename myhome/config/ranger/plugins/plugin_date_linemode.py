# Compatible since ranger 1.7.0
#
# This sample plugin adds a new linemode displaying the filename in rot13.
# Load this plugin by copying it to ~/.config/ranger/plugins/ and activate
# the linemode by typing ":linemode rot13" in ranger.  Type Mf to restore
# the default linemode.

import codecs
import ranger.api
from ranger.core.linemode import DefaultLinemode
from time import time, strftime, localtime

class DateLinemode(DefaultLinemode):
    timeformat = '%Y-%m-%d %H:%M'

    def infostring(self, file, metadata):
        ftime = file.stat.__getattribute__('st_' + self.name)
        return strftime(self.timeformat, localtime(ftime))

@ranger.api.register_linemode
class CTimeLinemode(DateLinemode):
    name = 'ctime'

@ranger.api.register_linemode
class CTimeLinemode(DateLinemode):
    name = 'mtime'
