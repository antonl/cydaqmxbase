""" Python bindings for NiDAQmx Base """

import ctypes

# This is necessary because of NI library annoyances
ctypes.CDLL("/usr/local/lib/liblvrtdark.so.12.0", mode=ctypes.RTLD_GLOBAL)

__author__ = 'Sean Vig <seanvig2@illinois.edu>'
__license__ = 'BSD'
__version__ = '0.0.2-git'

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
