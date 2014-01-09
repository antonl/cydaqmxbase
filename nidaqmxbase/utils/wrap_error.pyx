"""NI-DAQmx base error wrapping """

#-----------------------------------------------------------------------------
# Cython imports
#-----------------------------------------------------------------------------

from nidaqmxbase.external.libnidaqmxbase cimport (
    DAQmxBaseGetExtendedErrorInfo, DAQmxFailed
)

#-----------------------------------------------------------------------------
# Code
#-----------------------------------------------------------------------------

cdef inline void wrap_error(int32 error):
    cdef char errBuff[2048]

    if (DAQmxFailed(error)):
        DAQmxBaseGetExtendedErrorInfo(errBuff, 2048)
        print "DAQmxBase Error %ld: %s" % (error, errBuff)
        # TODO: raise error
