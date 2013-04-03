"""NI-DAQmx Base Digital I/O Tasks """

#-----------------------------------------------------------------------------
# Cython Imports
#-----------------------------------------------------------------------------

from nidaqmxbase.core.libnidaqmxbase cimport (
    DAQmxBaseCreateDIChan, DAQmxBaseReadDigitalU32,
    DAQmx_Val_GroupByChannel,
    int32, float64, bool32, uInt32
)
from nidaqmxbase.core.task cimport Task
from nidaqmxbase.utils.wrap_error cimport wrap_error

#-----------------------------------------------------------------------------
# Code
#-----------------------------------------------------------------------------

__all__ = ['DITask', 'DOTask']

cdef class DITask(Task):
    uInt32 _nchans = 0

    cdef void add_di_chan(Task self, const char lines[]):
        wrap_error(DAQmxBaseCreateDIChan(self.handle, lines, "", DAQmx_Val_ChanForAllLines))
        nchans += 1

    cdef uInt32[] read(Task self, int32 numSamples, float64 timeout=10.,
            bool32 fillMode=DAQmx_Val_GroupByChannel):
        """
        Read in a single reading from added channels

        Parameters
        ----------

        numSamples : int32
            The number of samples, per channel, to read. The default value of
            -1 (DAQmx_Val_Auto) reads all available data. If readArray does not
            contain enough space, this function returns as much data as fits in
            readArray.

        timeout : float64
            The amount of time, in seconds, to wait for the function to read
            the sample(s). This function returns an error if the timeout
            elapses. Default: 10.

        fillMode : bool32
            Specifies whether or not the samples are interleaved.
            DAQmx_Val_GroupByChannel: Group by channel (non-interleaved).
            DAQmx_Val_GroupByScanNumber: Group by scan number (interleaved).
            Default: DAQmx_Val_GroupByChannel)
        """

        cdef uInt32 readArray[nchans]
        cdef int32 sampsPerChanRead

        if not self._started:
            # TODO: raise error
            pass
        wrap_error(DAQmxBaseReadDigitalU32(self.handle, self._nchans, timeout,
            fillMode, readArray, 1, &sampsPerChanRead, NULL))

        return readArray


cdef class DOTask(Task):
    pass
