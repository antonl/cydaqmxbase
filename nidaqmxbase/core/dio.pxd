"""NI-DAQmx Base Digital I/O Tasks declarations"""

#------------------------------------------------------------------------------
# Cython Imports
#------------------------------------------------------------------------------

from libnidaqmxbase cimport Task, uInt32

#------------------------------------------------------------------------------
# Declarations
#------------------------------------------------------------------------------

cdef class DITask(Task):
    """A NI-DAQmx digital input task"""

    cpdef void add_di_chan(Task self, const char lines[])
    cpdef uInt32 read(Task self, int32 numSampsPerChan, float64 timeout, uInt32 arraySizeInSamps)
