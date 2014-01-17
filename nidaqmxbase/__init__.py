""" Python bindings for NiDAQmx Base """

import ctypes
from ctypes.utils import find_library

# This is necessary because of NI library annoyances
lvrtdark = find_library("lvrtdark")
if lvrtdark:
    ctypes.CDLL(lvrtdark, mode=ctypes.RTLD_GLOBAL)
else:
    raise ImportError("Unable to find LabView Runtime Engine (liblvrtdark)")

from release import author, license, version

__author__ = author
__license__ = license
__version__ = version

# Top-level imports
from nidaqmxbase import dio
from nidaqmxbase import external
from nidaqmxbase import task
from nidaqmxbase import utils
from nidaqmxbase.dio import *
from nidaqmxbase.task import *

__all__ = []
for submod in [dio, task]:
    __all__.extend(submod.__all__)
