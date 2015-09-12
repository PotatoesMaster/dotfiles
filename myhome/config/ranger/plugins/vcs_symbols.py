import ranger.gui.widgets

ranger.gui.widgets.Widget.vcsfilestatus_symb = {'conflict':  ('X', ["vcsconflict"]),
        'untracked': ('+', ["vcschanged"]),
        'deleted':   ('-', ["vcschanged"]),
        'changed':   ('*', ["vcschanged"]),
        'staged':    ('×', ["vcsstaged"]),
        'ignored':   ('·', ["vcsignored"]),
        'sync':      (' ', ["vcssync"]),
        'none':      (' ', []),
        'unknown':   ('?', ["vcsunknown"])}
