""" Python bindings for NiDAQmx Base """

import ctypes

# This is necessary because of NI library annoyances
ctypes.CDLL("/usr/local/lib/liblvrtdark.so.12.0", mode=ctypes.RTLD_GLOBAL)

# Top-level imports
from nidaqmxbase import core
from nidaqmxbase import utils
from nidaqmxbase.core import *

__all__ = core.__all__
