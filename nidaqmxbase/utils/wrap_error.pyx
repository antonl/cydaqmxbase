"""NI-DAQmx base error wrapping """

#-----------------------------------------------------------------------------
# Cython imports
#-----------------------------------------------------------------------------

from nidaqmxbase.core.libnidaqmxbase cimport (
        DAQmxBaseGetExtendedErrorInfo, DAQmxFailed
)

#-----------------------------------------------------------------------------
# Coding
#-----------------------------------------------------------------------------

cdef inline void wrap_error(int32 error):
    char errBuff[2048];

    if (DAQmxFailed(error)):
        DAQmxBaseGetExtendedErrorInfo(errBuff, 2048);
        print "DAQmxBase Error %ld: %s" % (error, errBuff);
        return 0;
