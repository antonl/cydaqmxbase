"""NI-DAQmx Base Digital Input Tasks declarations"""

#------------------------------------------------------------------------------
# Cython Imports
#------------------------------------------------------------------------------

cimport numpy as np

from nidaqmxbase.task.task cimport Task
from nidaqmxbase.external.libnidaqmxbase cimport int32, float64, bool32

#------------------------------------------------------------------------------
# Declarations
#------------------------------------------------------------------------------

ctypedef np.uint32_t DATA_DTYPE_t

cdef class DITask(Task):
    """A NI-DAQmx digital input task"""

    cdef int _nchans

    cpdef add_di_chan(DITask self, const char lines[])
    cpdef np.ndarray read(DITask self, int32 numSamples, float64 timeout=*,
        bool32 fillMode=*)
