""" All the C imports for NIDAQmx Base """

#-----------------------------------------------------------------------------
# Import the C header files
#-----------------------------------------------------------------------------

cdef inline int DAQmxFailed(int error): return (error != 0)

cdef extern from "NIDAQmxBase.h":
    # NI-DAQmx Typedefs
    ctypedef signed char int8
    ctypedef unsigned char uInt8
    ctypedef signed short int16
    ctypedef unsigned short uInt16
    ctypedef signed long int32
    ctypedef unsigned long uInt32
    ctypedef float float32
    ctypedef double float64
    ctypedef long long int64
    ctypedef unsigned long long uInt64
    ctypedef uInt32 bool32
    ctypedef uInt32 TaskHandle

    # Task Configuration/Control
    int32 DAQmxBaseLoadTask (const char taskName[], TaskHandle *taskHandle)
    int32 DAQmxBaseCreateTask (const char taskName[], TaskHandle *taskHandle)
    int32 DAQmxBaseStartTask (TaskHandle taskHandle)
    int32 DAQmxBaseStopTask (TaskHandle taskHandle)
    int32 DAQmxBaseClearTask (TaskHandle taskHandle)
    int32 DAQmxBaseIsTaskDone (TaskHandle taskHandle, bool32 *isTaskDone)

    # Channel Configuration/Creation
    int32 DAQmxBaseCreateAIVoltageChan (TaskHandle taskHandle, const char physicalChannel[], const char nameToAssignToChannel[], int32 terminalConfig, float64 minVal, float64 maxVal, int32 units, const char customScaleName[])
    int32 DAQmxBaseCreateAIThrmcplChan (TaskHandle taskHandle, const char physicalChannel[], const char nameToAssignToChannel[], float64 minVal, float64 maxVal, int32 units, int32 thermocoupleType, int32 cjcSource, float64 cjcVal, const char cjcChannel[])
    int32 DAQmxBaseCreateAOVoltageChan (TaskHandle taskHandle, const char physicalChannel[], const char nameToAssignToChannel[], float64 minVal, float64 maxVal, int32 units, const char customScaleName[])
    int32 DAQmxBaseCreateDIChan (TaskHandle taskHandle, const char lines[], const char nameToAssignToLines[], int32 lineGrouping)
    int32 DAQmxBaseCreateDOChan (TaskHandle taskHandle, const char lines[], const char nameToAssignToLines[], int32 lineGrouping)
    int32 DAQmxBaseCreateCIPeriodChan (TaskHandle taskHandle, const char counter[], const char nameToAssignToChannel[], float64 minVal, float64 maxVal, int32 units, int32 edge, int32 measMethod, float64 measTime, uInt32 divisor, const char customScaleName[])
    int32 DAQmxBaseCreateCICountEdgesChan (TaskHandle taskHandle, const char counter[], const char nameToAssignToChannel[], int32 edge, uInt32 initialCount, int32 countDirection)
    int32 DAQmxBaseCreateCIPulseWidthChan (TaskHandle taskHandle, const char counter[], const char nameToAssignToChannel[], float64 minVal, float64 maxVal, int32 units, int32 startingEdge, const char customScaleName[])
    int32 DAQmxBaseCreateCILinEncoderChan (TaskHandle taskHandle, const char counter[], const char nameToAssignToChannel[], int32 decodingType, bool32 ZidxEnable, float64 ZidxVal, int32 ZidxPhase, int32 units, float64 distPerPulse, float64 initialPos, const char customScaleName[])
    int32 DAQmxBaseCreateCIAngEncoderChan (TaskHandle taskHandle, const char counter[], const char nameToAssignToChannel[], int32 decodingType, bool32 ZidxEnable, float64 ZidxVal, int32 ZidxPhase, int32 units, uInt32 pulsesPerRev, float64 initialAngle, const char customScaleName[])
    int32 DAQmxBaseCreateCOPulseChanFreq (TaskHandle taskHandle, const char counter[], const char nameToAssignToChannel[], int32 units, int32 idleState, float64 initialDelay, float64 freq, float64 dutyCycle)
    int32 DAQmxBaseGetChanAttribute (TaskHandle taskHandle, const char channel[], int32 attribute, void *value)
    int32 DAQmxBaseSetChanAttribute (TaskHandle taskHandle, const char channel[], int32 attribute, int32 value)

    # Timing
    int32 DAQmxBaseCfgSampClkTiming (TaskHandle taskHandle, const char source[], float64 rate, int32 activeEdge, int32 sampleMode, uInt64 sampsPerChan)
    int32 DAQmxBaseCfgImplicitTiming (TaskHandle taskHandle, int32 sampleMode, uInt64 sampsPerChan)

    # Triggering
    int32 DAQmxBaseDisableStartTrig (TaskHandle taskHandle)
    int32 DAQmxBaseCfgDigEdgeStartTrig (TaskHandle taskHandle, const char triggerSource[], int32 triggerEdge)
    int32 DAQmxBaseCfgAnlgEdgeStartTrig (TaskHandle taskHandle, const char triggerSource[], int32 triggerSlope, float64 triggerLevel)
    int32 DAQmxBaseDisableRefTrig (TaskHandle taskHandle)
    int32 DAQmxBaseCfgDigEdgeRefTrig (TaskHandle taskHandle, const char triggerSource[], int32 triggerEdge, uInt32 pretriggerSamples)
    int32 DAQmxBaseCfgAnlgEdgeRefTrig (TaskHandle taskHandle, const char triggerSource[], int32 triggerSlope, float64 triggerLevel, uInt32 pretriggerSamples)

    # Read Data
    int32 DAQmxBaseReadAnalogF64 (TaskHandle taskHandle, int32 numSampsPerChan, float64 timeout, bool32 fillMode, float64 readArray[], uInt32 arraySizeInSamps, int32 *sampsPerChanRead, bool32 *reserved)
    int32 DAQmxBaseReadBinaryI16 (TaskHandle taskHandle, int32 numSampsPerChan, float64 timeout, bool32 fillMode, int16 readArray[], uInt32 arraySizeInSamps, int32 *sampsPerChanRead, bool32 *reserved)
    int32 DAQmxBaseReadBinaryI32 (TaskHandle taskHandle, int32 numSampsPerChan, float64 timeout, bool32 fillMode, int32 readArray[], uInt32 arraySizeInSamps, int32 *sampsPerChanRead, bool32 *reserved)
    int32 DAQmxBaseReadDigitalU8 (TaskHandle taskHandle, int32 numSampsPerChan, float64 timeout, bool32 fillMode, uInt8 readArray[], uInt32 arraySizeInSamps, int32 *sampsPerChanRead, bool32 *reserved)
    int32 DAQmxBaseReadDigitalScalarU32 (TaskHandle taskHandle, float64 timeout, uInt32 *value, bool32 *reserved)
    int32 DAQmxBaseReadCounterF64 (TaskHandle taskHandle, int32 numSampsPerChan, float64 timeout, float64 readArray[], uInt32 arraySizeInSamps, int32 *sampsPerChanRead, bool32 *reserved)
    int32 DAQmxBaseReadCounterU32 (TaskHandle taskHandle, int32 numSampsPerChan, float64 timeout, uInt32 readArray[], uInt32 arraySizeInSamps, int32 *sampsPerChanRead, bool32 *reserved)
    int32 DAQmxBaseReadCounterScalarF64 (TaskHandle taskHandle, float64 timeout, float64 *value, bool32 *reserved)
    int32 DAQmxBaseReadCounterScalarU32 (TaskHandle taskHandle, float64 timeout, uInt32 *value, bool32 *reserved)
    int32 DAQmxBaseGetReadAttribute (TaskHandle taskHandle, int32 attribute, void *value)

    # Write Data
    int32 DAQmxBaseWriteAnalogF64 (TaskHandle taskHandle, int32 numSampsPerChan, bool32 autoStart, float64 timeout, bool32 dataLayout, float64 writeArray[], int32 *sampsPerChanWritten, bool32 *reserved)
    int32 DAQmxBaseWriteDigitalU8 (TaskHandle taskHandle, int32 numSampsPerChan, bool32 autoStart, float64 timeout, bool32 dataLayout, uInt8 writeArray[], int32 *sampsPerChanWritten, bool32 *reserved)
    int32 DAQmxBaseWriteDigitalU32 (TaskHandle taskHandle, int32 numSampsPerChan, bool32 autoStart, float64 timeout, bool32 dataLayout, uInt32 writeArray[], int32 *sampsPerChanWritten, bool32 *reserved)
    int32 DAQmxBaseGetWriteAttribute (TaskHandle taskHandle, int32 attribute, void *value)
    int32 DAQmxBaseSetWriteAttribute (TaskHandle taskHandle, int32 attribute, int32 value)

    # Events & Signals
    int32 DAQmxBaseExportSignal (TaskHandle taskHandle, int32 signalID, const char outputTerminal[])

    # Buffer Configurations
    int32 DAQmxBaseCfgInputBuffer (TaskHandle taskHandle, uInt32 numSampsPerChan)

    # Device Control
    int32 DAQmxBaseResetDevice (const char deviceName[])

    # Error Handling
    int32 DAQmxBaseGetExtendedErrorInfo (char errorString[], uInt32 bufferSize)

    # Device Functions
    int32 DAQmxBaseGetDevSerialNum (const char device[], uInt32 *data)

    # Attributes
    # Calibration info attribures
    enum:
        DAQmx_SelfCal_Supported                                             # 0x1860 Indicates whether the device supports self calibration.
        DAQmx_SelfCal_LastTemp
        DAQmx_ExtCal_RecommendedInterval
        DAQmx_ExtCal_LastTemp
        DAQmx_Cal_UserDefinedInfo
        DAQmx_Cal_UserDefinedInfo_MaxSize
    # Channel attributes
    enum:
        DAQmx_ChanType
        DAQmx_PhysicalChanName
        DAQmx_ChanDescr
        DAQmx_AI_Max
    # TODO: rest of attributes
    # Values for the Line Grouping parameter of DAQmxCreateDIChan and DAQmxCreateDOChan
    enum:
        DAQmx_Val_ChanPerLine                                               # 0 One Channel For Each Line
        DAQmx_Val_ChanForAllLines                                           # 1 One Channel For All Lines

    # Error codes
    enum:
        DAQmxSuccess                                                        # 0
        DAQmxErrorInvalidInstallation                                       # -200683
    # TODO: rest of error codes
