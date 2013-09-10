#! /usr/bin/env python3

import os
import os.path

dotfiles_dir = os.path.dirname(os.path.realpath(__file__))
for f in os.listdir(dotfiles_dir):
    if f == os.path.basename(__file__):
        continue
    try:
        os.symlink(os.path.join(dotfiles_dir, f),
                   os.path.join(os.environ['HOME'], '.' + f))
    except OSError as err:
        print('Skiping {}   Reason: {}'.format(f, err))
