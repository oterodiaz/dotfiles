#!/usr/bin/env python3

import glob
from pynvim import attach

nvim_sockets = (attach('socket', path=p) for p in glob.glob('/tmp/nvim/nvim*.sock'))

for nvim in nvim_sockets:
    nvim.exec_lua('updateColorscheme()')
