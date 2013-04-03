"""NI-DAQmx Base Digital I/O Tasks declarations"""

#------------------------------------------------------------------------------
# Cython Imports
#------------------------------------------------------------------------------

from nidaqmxbase.core.libnidaqmxbase cimport int32, float64, uInt32, bool32, DAQmx_Val_GroupByChannel
from nidaqmxbase.core.task import Task

#------------------------------------------------------------------------------
# Declarations
#------------------------------------------------------------------------------

cdef class DITask:#(Task):
    """A NI-DAQmx digital input task"""

    cdef void add_di_chan(DITask self, const char lines[])
    cdef void read(DITask self, int32 numSamples, float64 timeout=*,
            bool32 fillMode=*)
