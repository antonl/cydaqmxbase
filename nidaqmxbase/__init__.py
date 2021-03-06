""" Python bindings for NiDAQmx Base """
from __future__ import absolute_import

import ctypes
from ctypes.util import find_library

# This is necessary because of NI library annoyances
lvrtdark = find_library("lvrtdark")
if lvrtdark:
    try:
        ctypes.CDLL(lvrtdark, mode=ctypes.RTLD_GLOBAL)
    except OSError:
        pass

from .release import author, license, version

__author__ = author
__license__ = license
__version__ = version

# Top-level imports
from nidaqmxbase import digital
from nidaqmxbase import external
from nidaqmxbase import task
from nidaqmxbase import utils
from nidaqmxbase.digital import *
from nidaqmxbase.task import *

__all__ = []
for submod in [digital, task]:
    __all__.extend(submod.__all__)
