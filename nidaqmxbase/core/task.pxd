"""Ni-DAQmx Base Tasks declarations """

#-----------------------------------------------------------------------------
# Cython Imports
#-----------------------------------------------------------------------------

from libnidaqmxbase cimport TaskHandle

#-----------------------------------------------------------------------------
# Declaration
#-----------------------------------------------------------------------------

cdef class Task:
    """A Ni-DAQmx Task"""

    #cdef TaskHandle handle
    cdef int handle
