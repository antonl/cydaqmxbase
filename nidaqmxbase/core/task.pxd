"""Ni-DAQmx Base Tasks declarations """

#-----------------------------------------------------------------------------
# Cython Imports
#-----------------------------------------------------------------------------

from libnidaqmxbase import TaskHandle

#-----------------------------------------------------------------------------
# Declaration
#-----------------------------------------------------------------------------

cdef class Task:
    """A Ni-DAQmx Task"""

    #cdef TaskHandle handle
    cdef int handle
