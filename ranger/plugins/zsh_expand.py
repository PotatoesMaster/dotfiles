import os.path
from ranger.ext.spawn import spawn

vanilla_expand = os.path.expanduser
hashes = [x.split('=') for x in spawn('zsh', '-ic', 'hash -d')[:-1].split('\n')]
hashes = {k: v for (k, v) in hashes}

def zsh_expand(path):
    global hashes

    if len(path) > 1 and path[0] == '~' and path[1] != '/':
        if '/' in path:
            end = path.index('/')
        else:
            end = len(path)
        name = path[1:end]
        if name in hashes:
            return hashes[name] + path[end:]
    return vanilla_expand(path)

os.path.expanduser = zsh_expand
