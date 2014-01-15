"""NI-DAQmx Base Digital I/O Tasks """

#-----------------------------------------------------------------------------
# Cython Imports
#-----------------------------------------------------------------------------

import numpy as np
cimport numpy as np

from nidaqmxbase.task.task cimport Task
from nidaqmxbase.external.libnidaqmxbase cimport (
    DAQmxBaseCreateDIChan, DAQmxBaseReadDigitalU32,
    DAQmxBaseCreateDOChan, DAQmxBaseWriteDigitalU32,
    DAQmx_Val_GroupByChannel, DAQmx_Val_ChanForAllLines,
    int32, float64, bool32, uInt32
)
from nidaqmxbase.utils.wrap_error cimport wrap_error

#-----------------------------------------------------------------------------
# Code
#-----------------------------------------------------------------------------

__all__ = ['DITask', 'DOTask']

DATA_DTYPE = np.uint32
#ctypedef np.uint32_t DATA_DTYPE_t

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
        wrap_error(DAQmxBaseCreateDIChan(
            self.handle, lines, "", DAQmx_Val_ChanForAllLines
        ))
        # ... not technically correct, may be >1
        self._nchans += 1

    cpdef np.ndarray read(DITask self, int32 numSamples, float64 timeout=1.,
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

        cdef np.ndarray[DATA_DTYPE_t,ndim=1] readArray = \
                np.zeros((self._nchans), dtype=DATA_DTYPE)
        cdef int32 sampsPerChanRead

        if not self._started:
            # TODO: raise error
            pass
        wrap_error(DAQmxBaseReadDigitalU32(
            self.handle, self._nchans, timeout, fillMode,
            <uInt32*> readArray.data, 1, &sampsPerChanRead, NULL
        ))

        return readArray


cdef class DOTask(Task):
    def __cinit__(DOTask self, const char taskName[]=""):
        self._nchans = 0

    def __init__(DOTask self, const char taskName[]=""):
        pass

    cpdef add_do_chan(DOTask self, const char lines[]):
        """
        Add digital output line

        Parameters
        ----------

        lines : string
            The names of the digital lines used to create a virtual channel.
            You can specify a list or range of lines such as the following:
            Dev1/port0:1 or Dev1/port0,Dev1/port2 or Dev1/port0/line0:4
        """
        wrap_error(DAQmxBaseCreateDOChan(
            self.handle, lines, "", DAQmx_Val_ChanForAllLines
        ))
        # ... not technically correct, may be >1
        self._nchans += 1

    cpdef int32 write(DOTask self, np.ndarray[DATA_DTYPE_t,ndim=1] writeArray,
            int32 numSampsPerChan, bool32 dataLayout=DAQmx_Val_GroupByChannel,
            bool32 autoStart=True, float64 timeout=1.):
        """
        Write a single value for added channels

        Parameters
        ----------

        writeArray : ndarray[np.uint32, ndim=1]
            The array of 32-bit integer samples to write to the task.

        numSampsPerChan : int32
            The number of samples, per channel, to write. You must pass in a
            value of 0 or more in order for the sample to write. If you pass a
            negative number, this function returns an error.

        dataLayout : bool32
            Specifies how the samples are arranged, either interleaved or non-interleaved.
            DAQmx_Val_GroupByChannel: Group by channel (non-interleaved)
            DAQmx_Val_GroupByScanNumber: Group by sample (interleaved)
            Default: DAQmx_Val_GroupByChannel

        autoStart : bool32
            Specifies whether or not this function automatically starts the
            task if you do not start it. This is used only for static digital
            tasks, otherwise set autoStart to False.
            Default: True

        timeout : float64
            The amount of time, in seconds, to wait for this function to write
            all the samples. This function returns an error if the timeout
            elapses.
            Default: 1.0
        """

        cdef int32 sampsPerChanWritten

        wrap_error(DAQmxBaseWriteDigitalU32(
            self.handle, numSampsPerChan, autoStart, timeout, dataLayout,
            <uInt32*> writeArray.data, &sampsPerChanWritten, NULL
        ))

        return sampsPerChanWritten
