"""NI-DAQmx base error wrapping """

#-----------------------------------------------------------------------------
# Cython imports
#-----------------------------------------------------------------------------

from nidaqmxbase.external.libnidaqmxbase cimport (
    DAQmxBaseGetExtendedErrorInfo, DAQmxFailed
)

#-----------------------------------------------------------------------------
# Imports
#-----------------------------------------------------------------------------

from nidaqmxbase.error import NIDAQmxBaseError

#-----------------------------------------------------------------------------
# Code
#-----------------------------------------------------------------------------

cdef inline void wrap_error(int32 error):
    cdef char errBuff[2048]

    if (DAQmxFailed(error)):
        DAQmxBaseGetExtendedErrorInfo(errBuff, 2048)
        raise NIDAQmxBaseError(error, errBuff)
