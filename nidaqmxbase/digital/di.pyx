"""NI-DAQmx Base Digital I/O Tasks """

#-----------------------------------------------------------------------------
# Cython Imports
#-----------------------------------------------------------------------------

import numpy as np
cimport numpy as np

from nidaqmxbase.task.task cimport Task
from nidaqmxbase.external.libnidaqmxbase cimport (
    DAQmxBaseCreateDIChan, DAQmxBaseReadDigitalU32,
    DAQmx_Val_GroupByChannel, DAQmx_Val_GroupByScanNumber,
    DAQmx_Val_ChanForAllLines, DAQmx_Val_Auto,
    int32, float64, bool32, uInt32
)
from nidaqmxbase.utils.wrap_error cimport wrap_error

from nidaqmxbase.utils.parseports import parseports

#-----------------------------------------------------------------------------
# Code
#-----------------------------------------------------------------------------

__all__ = ['DITask']

DATA_DTYPE = np.uint32

cdef class DITask(Task):
    def __cinit__(DITask self, const char taskName[]=""):
        self._nchans = 0

    def __init__(DITask self, const char taskName[]=""):
        pass

    cpdef add_di_chan(DITask self, const char lines[]):
        """
        Add digital input line

        Parameters
        ----------

        lines : string
            The names of the digital lines used to create a virtual channel.
            You can specify a list or range of lines such as the following:
            Dev1/port0:1 or Dev1/port0,Dev1/port2 or Dev1/port0/line0:4
        """
        ports = parseports(lines)
        for port in ports:
            wrap_error(DAQmxBaseCreateDIChan(
                self.handle, port, "", DAQmx_Val_ChanForAllLines
            ))
        self._nchans += len(ports)

    cpdef np.ndarray read(DITask self, int32 numSamples=DAQmx_Val_Auto, int32
            sampleSize=1, float64 timeout=1., bool32
            fillMode=DAQmx_Val_GroupByChannel):
        """
        Read in a single reading from added channels

        Parameters
        ----------

        numSamples : int32
            The number of samples, per channel, to read. The default value of
            -1 (DAQmx_Val_Auto) reads all available data. If readArray does not
            contain enough space, this function returns as much data as fits in
            readArray.  Default: DAQmx_Val_Auto.

        sampleSize : int32
            If numSamples is set to -1, this specifies the maximum number of
            samples to try to collect.  Default: 1.

        timeout : float64
            The amount of time, in seconds, to wait for the function to read
            the sample(s). This function returns an error if the timeout
            elapses.  Default: 10.

        fillMode : bool32
            Specifies whether or not the samples are interleaved.
            DAQmx_Val_GroupByChannel: Group by channel (non-interleaved).
            DAQmx_Val_GroupByScanNumber: Group by scan number (interleaved).
            Default: DAQmx_Val_GroupByChannel)
        """

        if not self._started:
            return np.array([], dtype=DATA_DTYPE)

        if numSamples == -1:
            nSamps = self._nchans * sampleSize
        else:
            nSamps = self._nchans * numSamples

        if fillMode == DAQmx_Val_GroupByChannel:
            dim = (self._nchans, nSamps // self._nchans)
        else:
            dim = (nSamps // self._nchans, self._nchans)

        cdef np.ndarray[DATA_DTYPE_t, ndim=2] readArray = \
                np.zeros(dim, dtype=DATA_DTYPE)
        cdef int32 sampsPerChanRead

        wrap_error(DAQmxBaseReadDigitalU32(
            self.handle, numSamples, timeout, fillMode,
            <uInt32*> readArray.data, nSamps, &sampsPerChanRead, NULL
        ))

        return readArray
