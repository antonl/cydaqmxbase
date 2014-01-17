"""NI-DAQmx Base Digital I/O Tasks declarations"""

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

cdef class DOTask(Task):
    """A NI-DAQmx digital output task"""

    cdef int _nchans

    cpdef add_do_chan(DOTask self, const char lines[])
    cpdef int32 write(DOTask self, np.ndarray[DATA_DTYPE_t,ndim=1] writeArray,
        int32 numSampsPerChan, bool32 dataLayout=*, bool32 autoStart=*,
        float64 timeout=*)
