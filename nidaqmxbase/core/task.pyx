"""NI-DAQmx Base Tasks """

#-----------------------------------------------------------------------------
# Cython Imports
#-----------------------------------------------------------------------------

from nidaqmxbase.core.libnidaqmxbase cimport (
	TaskHandle, DAQmxBaseCreateTask, DAQmxBaseStartTask, DAQmxBaseStopTask,
	DAQmxBaseClearTask
)
from nidaqmxbase.utils.wrap_error cimport wrap_error

#-----------------------------------------------------------------------------
# Code
#-----------------------------------------------------------------------------

__all__ = ['Task']

cdef class Task:
    def __cinit__(self, const char taskName[]=""):
        cdef TaskHandle taskHandle
        wrap_error(DAQmxBaseCreateTask(taskName, &taskHandle))
        self.handle = taskHandle

    def __init__(self, taskName=""):
        self._started = False

    def __dealloc__(self):
        wrap_error(DAQmxBaseStopTask(self.handle))
        wrap_error(DAQmxBaseClearTask(self.handle))

    cpdef start(Task self):
        wrap_error(DAQmxBaseStartTask(self.handle))
        self._started = 1
