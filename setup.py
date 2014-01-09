#!/usr/bin/env python

#-----------------------------------------------------------------------------
# Imports
#-----------------------------------------------------------------------------

from distutils.core import setup
from distutils.extension import Extension
from Cython.Distutils import build_ext

import os
import numpy as np

import nidaqmxbase

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
# Extensions
#-----------------------------------------------------------------------------

def pxd(subdir, name):
    return os.path.abspath(os.path.join('nidaqmxbase', subdir, name+'.pxd'))

libnidaqmxbase = pxd('core', 'libnidaqmxbase')
task = pxd('core', 'task')
wrap_error = pxd('utils', 'wrap_error')

submodules = dict(
    core = {
        'task': [libnidaqmxbase, wrap_error],
        'dio': [libnidaqmxbase, task, wrap_error]
    },
    utils = {'wrap_error': [libnidaqmxbase]}
)

extensions = []
for submod, packages in submodules.items():
    for pkg in sorted(packages):
        sources = [os.path.join('nidaqmxbase', submod, pkg+'.pyx')]
        sources.extend(packages[pkg])
        ext = Extension(
            'nidaqmxbase.%s.%s' % (submod, pkg),
            sources = sources,
            include_dirs = [os.path.join('nidaqmxbase', sub) for sub in ('utils','core')] + [np.get_include()],
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

setup(
    name='cydaqmxbase',
    version=nidaqmxbase.__version__,
    description='Cython wrapper for NI-DAQmx Base',
    author=nidaqmxbase.__author__,
    license=nidaqmxbase.__license__,
    packages=find_packages(),
    cmdclass={'build_ext': build_ext},
    ext_modules=extensions,
    include_dirs=includes
)
