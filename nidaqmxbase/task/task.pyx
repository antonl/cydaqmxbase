"""NI-DAQmx Base Tasks """

#-----------------------------------------------------------------------------
# Cython Imports
#-----------------------------------------------------------------------------

from nidaqmxbase.external.libnidaqmxbase cimport (
    TaskHandle, DAQmxBaseCreateTask, DAQmxBaseStartTask, DAQmxBaseStopTask,
    DAQmxBaseClearTask, DAQmxBaseIsTaskDone,
    bool32
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
        self.stop()
        wrap_error(DAQmxBaseClearTask(self.handle))

    cpdef start(Task self):
        if not self._started:
            wrap_error(DAQmxBaseStartTask(self.handle))
            self._started = True

    cpdef stop(Task self):
        if self._started:
            wrap_error(DAQmxBaseStopTask(self.handle))
            self._started = False

    cpdef isDone(Task self):
        cdef bool32 taskDone
        wrap_error(DAQmxBaseIsTaskDone(self.handle, &taskDone))
        return taskDone
