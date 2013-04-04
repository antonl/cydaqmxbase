"""Ni-DAQmx Base Tasks declarations """

#-----------------------------------------------------------------------------
# Cython Imports
#-----------------------------------------------------------------------------

from nidaqmxbase.core.libnidaqmxbase cimport TaskHandle

#-----------------------------------------------------------------------------
# Declaration
#-----------------------------------------------------------------------------

cdef class Task:
    """A Ni-DAQmx Task"""
    cpdef TaskHandle handle
    cpdef start(Task self)
