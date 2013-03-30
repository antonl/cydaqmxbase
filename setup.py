#!/usr/bin/env python

from distutils.core import setup
from distutils.extension import Extension
from Cython.Distutils import build_ext

import os

def pxd(subdir, name):
    return os.path.abspath(os.path.join('nidaqmxbase', subdir, name+'.pxd'))

libnidaqmxbase = pxd('core', 'libnidaqmxbase')
wrap_error = pxd('utils', 'wrap_error')

submodules = dict(
    core = {'task': [libnidaqmxbase, wrap_error]},
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
            include_dirs = [os.path.join('nidaqmxbase', sub) for sub in ('utils','core')],
            libraries = ["nidaqmxbase"]
        )
        extensions.append(ext)

def find_packages():
    packages = []
    for dir, subdir, files in os.walk('nidaqmxbase'):
        package = dir.replace(os.path.sep, '.')
        if '__init__.py' not in files:
            continue
        packages.append(package)
    return packages

setup(
    name = "cydaqmxbase",
    packages = find_packages(),
    cmdclass = {'build_ext': build_ext},
    ext_modules = extensions
)
