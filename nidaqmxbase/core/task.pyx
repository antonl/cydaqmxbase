"""Ni-DAQmx Base Tasks """

#-----------------------------------------------------------------------------
# Cython Imports
#-----------------------------------------------------------------------------

from nidaqmxbase.core.libnidaqmxbase cimport TaskHandle, DAQmxBaseCreateTask, DAQmxStopTask, DAQmxClearTask
from nidaqmxbase.utils.wrap_error cimport wrap_error

#-----------------------------------------------------------------------------
# Code
#-----------------------------------------------------------------------------

cdef class Task:
    def __cinit__(self, const char taskName[]=""):
        #cdef TaskHandle taskHandle
        cdef int taskHandle
        wrap_error(DAQmxBaseCreateTask(taskName, &taskHandle))
        self.handle = taskHandle

    def __init__(self, taskName):
        pass

    def __dealloc__(self):
        wrap_error(DAQmxStopTask(self.handle))
        wrap_error(DAQmxClearTask(self.handle))
