"""Ni-DAQmx Base Tasks declarations """

#-----------------------------------------------------------------------------
# Cython Imports
#-----------------------------------------------------------------------------

from nidaqmxbase.external.libnidaqmxbase cimport TaskHandle, bool32

#-----------------------------------------------------------------------------
# Declaration
#-----------------------------------------------------------------------------

cdef class Task:
    """A Ni-DAQmx Task"""
    cpdef TaskHandle handle
    cdef bool32 _started
    cpdef start(Task self)
    cpdef stop(Task self)
    cpdef isDone(Task self)
