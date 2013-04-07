"""NI-DAQmx Base Digital I/O Tasks declarations"""

#------------------------------------------------------------------------------
# Cython Imports
#------------------------------------------------------------------------------

cimport numpy as np

from nidaqmxbase.core.libnidaqmxbase cimport int32, float64, uInt32, bool32, DAQmx_Val_GroupByChannel
from nidaqmxbase.core.task cimport Task

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

cdef class DOTask(Task):
    """A NI-DAQmx digital output task"""

    cdef int _nchans

    cpdef add_do_chan(DOTask self, const char lines[])
    cpdef int32 write(DOTask self, np.ndarray[DATA_DTYPE_t,ndim=1] writeArray,
        int32 numSampsPerChan, bool32 dataLayout=*, bool32 autoStart=*,
        float64 timeout=*)
