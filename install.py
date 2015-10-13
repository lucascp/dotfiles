#! /usr/bin/env python3

import os
import os.path

dotfiles_dir = os.path.dirname(os.path.realpath(__file__))
home_dir = os.environ['HOME']
for dirpath, dirnames, filenames in os.walk(dotfiles_dir):
    if ".git" in dirnames:
        dirnames.remove(".git")
    for f in filenames:
        if f == os.path.basename(__file__):
            continue
        _, ext = os.path.splitext(f)
        if ext == '.md':
            continue
        try:
            origin = os.path.join(dirpath, f)
            if dirpath == dotfiles_dir:
                f = '.' + f
            relative_path = os.path.relpath(dirpath, dotfiles_dir)
            destination_dir = os.path.join(home_dir, relative_path)
            if not os.path.exists(destination_dir):
                os.makedirs(destination_dir)
            destination = os.path.join(destination_dir, f)
            #print (origin)
            #print (destination)
            os.symlink(origin, destination)
        except OSError as err:
            print('Skiping {}   Reason: {}'.format(f, err))

try:
    os.symlink(os.path.join(home_dir, '.vimrc'), os.path.join(home_dir, '.nvimrc'))
    os.symlink(os.path.join(home_dir, '.vim'), os.path.join(home_dir, '.nvim'))
except OSError as err:
    print('Skiping nvim files   Reason: {}'.format(err))
