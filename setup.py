#!/usr/bin/env python

#-----------------------------------------------------------------------------
# Imports
#-----------------------------------------------------------------------------

from distutils.core import setup, Command
from distutils.extension import Extension
from Cython.Distutils import build_ext

import os
import shutil
import numpy as np

#-----------------------------------------------------------------------------
# Packages
#-----------------------------------------------------------------------------

def find_packages():
    packages = []
    for dir, subdir, files in os.walk('nidaqmxbase'):
        package = dir.replace(os.path.sep, '.')
        if '__init__.py' not in files:
            continue
        packages.append(package)
    return packages

#-----------------------------------------------------------------------------
# Commands
#-----------------------------------------------------------------------------

class CleanCommand(Command):
    user_options = [('all', 'a', "remove all build output") ]

    boolean_options = ['all']

    def initialize_options(self):
        self.all = None

    def finalize_options(self):
        pass

    def run(self):
        self._clean_me = []
        self._clean_trees = []

        for root, dirs, files in list(os.walk('nidaqmxbase')):
            for f in files:
                if os.path.splitext(f)[-1] in ('.pyc', '.so', '.o', '.pyd'):
                    self._clean_me.append(os.path.join(root, f))
                # remove generated cython files if `all`
                if self.all and os.path.splitext(f)[-1] == '.c':
                    self._clean_me.append(os.path.join(root, f))

            for d in dirs:
                if d == '__pycache__':
                    self._clean_trees.append(os.path.join(root, d))

        if os.path.exists('build'):
            self._clean_trees.append(d)

        for clean_me in self._clean_me:
            try:
                os.unlink(clean_me)
            except Exception:
                pass

        for clean_tree in self._clean_trees:
            try:
                shutil.rmtree(clean_tree)
            except Exception:
                pass


#-----------------------------------------------------------------------------
# Extensions
#-----------------------------------------------------------------------------

def pxd(subdir, name):
    return os.path.abspath(os.path.join('nidaqmxbase', subdir, name+'.pxd'))

libnidaqmxbase = pxd('external', 'libnidaqmxbase')
task = pxd('task', 'task')
wrap_error = pxd('utils', 'wrap_error')

submodules = {
        'task': {'task': [libnidaqmxbase, wrap_error]},
        'dio': {'dio': [libnidaqmxbase, task, wrap_error]},
        'utils': {'wrap_error': [libnidaqmxbase]}
    }

extensions = []
for submod, packages in submodules.items():
    for pkg in sorted(packages):
        sources = [os.path.join('nidaqmxbase', submod, pkg+'.pyx')]
        sources.extend(packages[pkg])
        ext = Extension(
            'nidaqmxbase.%s.%s' % (submod, pkg),
            sources = sources,
            include_dirs = [np.get_include()],
            libraries = ["nidaqmxbase"]
        )
        extensions.append(ext)

#-----------------------------------------------------------------------------
# Include directories
#-----------------------------------------------------------------------------

includes = [os.path.normpath('/usr/local/natinst/nidaqmxbase/include')]

#-----------------------------------------------------------------------------
# Setup
#-----------------------------------------------------------------------------

# Get version, author, and license information into global namespace
with open(os.path.join('nidaqmxbase', 'release.py')) as f:
    lines = f.read()
exec(lines, globals())

setup(
    name='cydaqmxbase',
    version=version,
    description='Cython wrapper for NI-DAQmx Base',
    author=author,
    license=license,
    packages=find_packages(),
    cmdclass={'build_ext': build_ext, 'clean': CleanCommand},
    ext_modules=extensions,
    include_dirs=includes
)
