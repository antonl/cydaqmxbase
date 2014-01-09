""" All the C imports for NIDAQmx Base """

#-----------------------------------------------------------------------------
# Import the C header files
#-----------------------------------------------------------------------------

cdef inline int DAQmxFailed(int error): return (error != 0)

cdef extern from "NIDAQmxBase.h":
    #--------------------------------------------------------------------------
    # Typedefs
    #--------------------------------------------------------------------------
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

    #--------------------------------------------------------------------------
    # Function declarations
    #--------------------------------------------------------------------------

    # Task Configuration/Control
    int32 DAQmxBaseLoadTask (const char taskName[], TaskHandle *taskHandle)
    int32 DAQmxBaseCreateTask (const char taskName[], TaskHandle *taskHandle)
    int32 DAQmxBaseStartTask (TaskHandle taskHandle)
    int32 DAQmxBaseStopTask (TaskHandle taskHandle)
    int32 DAQmxBaseClearTask (TaskHandle taskHandle)
    int32 DAQmxBaseIsTaskDone (TaskHandle taskHandle, bool32 *isTaskDone)

    # Channel Configuration/Creation
    int32 DAQmxBaseCreateAIVoltageChan (TaskHandle taskHandle, const char
            physicalChannel[], const char nameToAssignToChannel[], int32
            terminalConfig, float64 minVal, float64 maxVal, int32 units, const
            char customScaleName[])
    int32 DAQmxBaseCreateAIThrmcplChan (TaskHandle taskHandle, const char
            physicalChannel[], const char nameToAssignToChannel[], float64
            minVal, float64 maxVal, int32 units, int32 thermocoupleType, int32
            cjcSource, float64 cjcVal, const char cjcChannel[])
    int32 DAQmxBaseCreateAOVoltageChan (TaskHandle taskHandle, const char
            physicalChannel[], const char nameToAssignToChannel[], float64
            minVal, float64 maxVal, int32 units, const char customScaleName[])
    int32 DAQmxBaseCreateDIChan (TaskHandle taskHandle, const char lines[],
            const char nameToAssignToLines[], int32 lineGrouping)
    int32 DAQmxBaseCreateDOChan (TaskHandle taskHandle, const char lines[],
            const char nameToAssignToLines[], int32 lineGrouping)
    int32 DAQmxBaseCreateCIPeriodChan (TaskHandle taskHandle, const char
            counter[], const char nameToAssignToChannel[], float64 minVal,
            float64 maxVal, int32 units, int32 edge, int32 measMethod, float64
            measTime, uInt32 divisor, const char customScaleName[])
    int32 DAQmxBaseCreateCICountEdgesChan (TaskHandle taskHandle, const char
            counter[], const char nameToAssignToChannel[], int32 edge, uInt32
            initialCount, int32 countDirection)
    int32 DAQmxBaseCreateCIPulseWidthChan (TaskHandle taskHandle, const char
            counter[], const char nameToAssignToChannel[], float64 minVal,
            float64 maxVal, int32 units, int32 startingEdge, const char
            customScaleName[])
    int32 DAQmxBaseCreateCILinEncoderChan (TaskHandle taskHandle, const char
            counter[], const char nameToAssignToChannel[], int32 decodingType,
            bool32 ZidxEnable, float64 ZidxVal, int32 ZidxPhase, int32 units,
            float64 distPerPulse, float64 initialPos, const char
            customScaleName[])
    int32 DAQmxBaseCreateCIAngEncoderChan (TaskHandle taskHandle, const char
            counter[], const char nameToAssignToChannel[], int32 decodingType,
            bool32 ZidxEnable, float64 ZidxVal, int32 ZidxPhase, int32 units,
            uInt32 pulsesPerRev, float64 initialAngle, const char
            customScaleName[])
    int32 DAQmxBaseCreateCOPulseChanFreq (TaskHandle taskHandle, const char
            counter[], const char nameToAssignToChannel[], int32 units, int32
            idleState, float64 initialDelay, float64 freq, float64 dutyCycle)
    int32 DAQmxBaseGetChanAttribute (TaskHandle taskHandle, const char
            channel[], int32 attribute, void *value)
    int32 DAQmxBaseSetChanAttribute (TaskHandle taskHandle, const char
            channel[], int32 attribute, int32 value)

    # Timing
    int32 DAQmxBaseCfgSampClkTiming (TaskHandle taskHandle, const char
            source[], float64 rate, int32 activeEdge, int32 sampleMode, uInt64
            sampsPerChan)
    int32 DAQmxBaseCfgImplicitTiming (TaskHandle taskHandle, int32 sampleMode,
            uInt64 sampsPerChan)

    # Triggering
    int32 DAQmxBaseDisableStartTrig (TaskHandle taskHandle)
    int32 DAQmxBaseCfgDigEdgeStartTrig (TaskHandle taskHandle, const char
            triggerSource[], int32 triggerEdge)
    int32 DAQmxBaseCfgAnlgEdgeStartTrig (TaskHandle taskHandle, const char
            triggerSource[], int32 triggerSlope, float64 triggerLevel)
    int32 DAQmxBaseDisableRefTrig (TaskHandle taskHandle)
    int32 DAQmxBaseCfgDigEdgeRefTrig (TaskHandle taskHandle, const char
            triggerSource[], int32 triggerEdge, uInt32 pretriggerSamples)
    int32 DAQmxBaseCfgAnlgEdgeRefTrig (TaskHandle taskHandle, const char
            triggerSource[], int32 triggerSlope, float64 triggerLevel, uInt32
            pretriggerSamples)

    # Read Data
    int32 DAQmxBaseReadAnalogF64 (TaskHandle taskHandle, int32 numSampsPerChan,
            float64 timeout, bool32 fillMode, float64 readArray[], uInt32
            arraySizeInSamps, int32 *sampsPerChanRead, bool32 *reserved)
    int32 DAQmxBaseReadBinaryI16 (TaskHandle taskHandle, int32 numSampsPerChan,
            float64 timeout, bool32 fillMode, int16 readArray[], uInt32
            arraySizeInSamps, int32 *sampsPerChanRead, bool32 *reserved)
    int32 DAQmxBaseReadBinaryI32 (TaskHandle taskHandle, int32 numSampsPerChan,
            float64 timeout, bool32 fillMode, int32 readArray[], uInt32
            arraySizeInSamps, int32 *sampsPerChanRead, bool32 *reserved)
    int32 DAQmxBaseReadCounterF64 (TaskHandle taskHandle, int32
            numSampsPerChan, float64 timeout, float64 readArray[], uInt32
            arraySizeInSamps, int32 *sampsPerChanRead, bool32 *reserved)
    int32 DAQmxBaseReadCounterScalarF64 (TaskHandle taskHandle, float64
            timeout, float64 *value, bool32 *reserved)
    int32 DAQmxBaseReadCounterScalarU32 (TaskHandle taskHandle, float64
            timeout, uInt32 *value, bool32 *reserved)
    int32 DAQmxBaseReadCounterU32 (TaskHandle taskHandle, int32
            numSampsPerChan, float64 timeout, uInt32 readArray[], uInt32
            arraySizeInSamps, int32 *sampsPerChanRead, bool32 *reserved)
    int32 DAQmxBaseReadDigitalScalarU32 (TaskHandle taskHandle, float64
            timeout, uInt32 *value, bool32 *reserved)
    int32 DAQmxBaseReadDigitalU32 (TaskHandle taskHandle, int32
            numSampsPerChan, float64 timeout, bool32 fillMode, uInt32
            readArray[], uInt32 arraySizeInSamps, int32 *sampsPerChanRead,
            bool32 *reserved)
    int32 DAQmxBaseReadDigitalU8 (TaskHandle taskHandle, int32 numSampsPerChan,
            float64 timeout, bool32 fillMode, uInt8 readArray[], uInt32
            arraySizeInSamps, int32 *sampsPerChanRead, bool32 *reserved)
    int32 DAQmxBaseGetReadAttribute (TaskHandle taskHandle, int32 attribute,
            void *value)

    # Write Data
    int32 DAQmxBaseWriteAnalogF64 (TaskHandle taskHandle, int32
            numSampsPerChan, bool32 autoStart, float64 timeout, bool32
            dataLayout, float64 writeArray[], int32 *sampsPerChanWritten,
            bool32 *reserved)
    int32 DAQmxBaseWriteDigitalU8 (TaskHandle taskHandle, int32
            numSampsPerChan, bool32 autoStart, float64 timeout, bool32
            dataLayout, uInt8 writeArray[], int32 *sampsPerChanWritten, bool32
            *reserved)
    int32 DAQmxBaseWriteDigitalU32 (TaskHandle taskHandle, int32
            numSampsPerChan, bool32 autoStart, float64 timeout, bool32
            dataLayout, uInt32 writeArray[], int32 *sampsPerChanWritten, bool32
            *reserved)
    int32 DAQmxBaseGetWriteAttribute (TaskHandle taskHandle, int32 attribute,
            void *value)
    int32 DAQmxBaseSetWriteAttribute (TaskHandle taskHandle, int32 attribute,
            int32 value)

    # Events & Signals
    int32 DAQmxBaseExportSignal (TaskHandle taskHandle, int32 signalID, const
            char outputTerminal[])

    # Buffer Configurations
    int32 DAQmxBaseCfgInputBuffer (TaskHandle taskHandle, uInt32
            numSampsPerChan)

    # Device Control
    int32 DAQmxBaseResetDevice (const char deviceName[])

    # Error Handling
    int32 DAQmxBaseGetExtendedErrorInfo (char errorString[], uInt32 bufferSize)

    # Device Functions
    int32 DAQmxBaseGetDevSerialNum (const char device[], uInt32 *data)

    #--------------------------------------------------------------------------
    # Attributes
    #--------------------------------------------------------------------------

    # Calibration info attribures
    enum:
        DAQmx_SelfCal_Supported
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
        DAQmx_AI_Min
        DAQmx_AI_CustomScaleName
        DAQmx_AI_MeasType
        DAQmx_AI_Voltage_Units
        DAQmx_AI_Temp_Units
        DAQmx_AI_Thrmcpl_Type
        DAQmx_AI_Thrmcpl_CJCSrc
        DAQmx_AI_Thrmcpl_CJCVal
        DAQmx_AI_Thrmcpl_CJCChan
        DAQmx_AI_RTD_Type
        DAQmx_AI_RTD_R0
        DAQmx_AI_RTD_A
        DAQmx_AI_RTD_B
        DAQmx_AI_RTD_C
        DAQmx_AI_Thrmstr_A
        DAQmx_AI_Thrmstr_B
        DAQmx_AI_Thrmstr_C
        DAQmx_AI_Thrmstr_R1
        DAQmx_AI_ForceReadFromChan
        DAQmx_AI_Current_Units
        DAQmx_AI_Strain_Units
        DAQmx_AI_StrainGage_GageFactor
        DAQmx_AI_StrainGage_PoissonRatio
        DAQmx_AI_StrainGage_Cfg
        DAQmx_AI_Resistance_Units
        DAQmx_AI_Freq_Units
        DAQmx_AI_Freq_ThreshVoltage
        DAQmx_AI_Freq_Hyst
        DAQmx_AI_LVDT_Units
        DAQmx_AI_LVDT_Sensitivity
        DAQmx_AI_LVDT_SensitivityUnits
        DAQmx_AI_RVDT_Units
        DAQmx_AI_RVDT_Sensitivity
        DAQmx_AI_RVDT_SensitivityUnits
        DAQmx_AI_Accel_Units
        DAQmx_AI_Accel_Sensitivity
        DAQmx_AI_Accel_SensitivityUnits
        DAQmx_AI_Coupling
        DAQmx_AI_Impedance
        DAQmx_AI_TermCfg
        DAQmx_AI_ResistanceCfg
        DAQmx_AI_LeadWireResistance
        DAQmx_AI_Bridge_Cfg
        DAQmx_AI_Bridge_NomResistance
        DAQmx_AI_Bridge_InitialVoltage
        DAQmx_AI_Bridge_ShuntCal_Enable
        DAQmx_AI_Bridge_ShuntCal_Select
        DAQmx_AI_Bridge_ShuntCal_GainAdjust
        DAQmx_AI_Bridge_Balance_CoarsePot
        DAQmx_AI_Bridge_Balance_FinePot
        DAQmx_AI_CurrentShunt_Loc
        DAQmx_AI_CurrentShunt_Resistance
        DAQmx_AI_Excit_Src
        DAQmx_AI_Excit_Val
        DAQmx_AI_Excit_UseForScaling
        DAQmx_AI_Excit_UseMultiplexed
        DAQmx_AI_Excit_ActualVal
        DAQmx_AI_Excit_DCorAC
        DAQmx_AI_Excit_VoltageOrCurrent
        DAQmx_AI_ACExcit_Freq
        DAQmx_AI_ACExcit_SyncEnable
        DAQmx_AI_ACExcit_WireMode
        DAQmx_AI_Atten
        DAQmx_AI_Lowpass_Enable
        DAQmx_AI_Lowpass_CutoffFreq
        DAQmx_AI_Lowpass_SwitchCap_ClkSrc
        DAQmx_AI_Lowpass_SwitchCap_ExtClkFreq
        DAQmx_AI_Lowpass_SwitchCap_ExtClkDiv
        DAQmx_AI_Lowpass_SwitchCap_OutClkDiv
        DAQmx_AI_ResolutionUnits
        DAQmx_AI_Resolution
        DAQmx_AI_Dither_Enable
        DAQmx_AI_Rng_High
        DAQmx_AI_Rng_Low
        DAQmx_AI_Gain
        DAQmx_AI_SampAndHold_Enable
        DAQmx_AI_AutoZeroMode
        DAQmx_AI_DataXferMech
        DAQmx_AI_DataXferReqCond
        DAQmx_AI_MemMapEnable
        DAQmx_AI_DevScalingCoeff
        DAQmx_AO_Max
        DAQmx_AO_Min
        DAQmx_AO_CustomScaleName
        DAQmx_AO_OutputType
        DAQmx_AO_Voltage_Units
        DAQmx_AO_Current_Units
        DAQmx_AO_OutputImpedance
        DAQmx_AO_LoadImpedance
        DAQmx_AO_ResolutionUnits
        DAQmx_AO_Resolution
        DAQmx_AO_DAC_Rng_High
        DAQmx_AO_DAC_Rng_Low
        DAQmx_AO_DAC_Ref_ConnToGnd
        DAQmx_AO_DAC_Ref_AllowConnToGnd
        DAQmx_AO_DAC_Ref_Src
        DAQmx_AO_DAC_Ref_Val
        DAQmx_AO_ReglitchEnable
        DAQmx_AO_UseOnlyOnBrdMem
        DAQmx_AO_DataXferMech
        DAQmx_AO_DataXferReqCond
        DAQmx_AO_MemMapEnable
        DAQmx_AO_DevScalingCoeff
        DAQmx_DI_InvertLines
        DAQmx_DI_NumLines
        DAQmx_DI_DigFltr_Enable
        DAQmx_DI_DigFltr_MinPulseWidth
        DAQmx_DO_InvertLines
        DAQmx_DO_NumLines
        DAQmx_DO_Tristate
        DAQmx_CI_Max
        DAQmx_CI_Min
        DAQmx_CI_CustomScaleName
        DAQmx_CI_MeasType
        DAQmx_CI_Freq_Units
        DAQmx_CI_Freq_Term
        DAQmx_CI_Freq_StartingEdge
        DAQmx_CI_Freq_MeasMeth
        DAQmx_CI_Freq_MeasTime
        DAQmx_CI_Freq_Div
        DAQmx_CI_Period_Units
        DAQmx_CI_Period_Term
        DAQmx_CI_Period_StartingEdge
        DAQmx_CI_Period_MeasMeth
        DAQmx_CI_Period_MeasTime
        DAQmx_CI_Period_Div
        DAQmx_CI_CountEdges_Term
        DAQmx_CI_CountEdges_Dir
        DAQmx_CI_CountEdges_DirTerm
        DAQmx_CI_CountEdges_InitialCnt
        DAQmx_CI_CountEdges_ActiveEdge
        DAQmx_CI_AngEncoder_Units
        DAQmx_CI_AngEncoder_PulsesPerRev
        DAQmx_CI_AngEncoder_InitialAngle
        DAQmx_CI_LinEncoder_Units
        DAQmx_CI_LinEncoder_DistPerPulse
        DAQmx_CI_LinEncoder_InitialPos
        DAQmx_CI_Encoder_DecodingType
        DAQmx_CI_Encoder_AInputTerm
        DAQmx_CI_Encoder_BInputTerm
        DAQmx_CI_Encoder_ZInputTerm
        DAQmx_CI_Encoder_ZIndexEnable
        DAQmx_CI_Encoder_ZIndexVal
        DAQmx_CI_Encoder_ZIndexPhase
        DAQmx_CI_PulseWidth_Units
        DAQmx_CI_PulseWidth_Term
        DAQmx_CI_PulseWidth_StartingEdge
        DAQmx_CI_TwoEdgeSep_Units
        DAQmx_CI_TwoEdgeSep_FirstTerm
        DAQmx_CI_TwoEdgeSep_FirstEdge
        DAQmx_CI_TwoEdgeSep_SecondTerm
        DAQmx_CI_TwoEdgeSep_SecondEdge
        DAQmx_CI_SemiPeriod_Units
        DAQmx_CI_SemiPeriod_Term
        DAQmx_CI_CtrTimebaseSrc
        DAQmx_CI_CtrTimebaseRate
        DAQmx_CI_CtrTimebaseActiveEdge
        DAQmx_CI_Count
        DAQmx_CI_OutputState
        DAQmx_CI_TCReached
        DAQmx_CI_CtrTimebaseMasterTimebaseDiv
        DAQmx_CI_DataXferMech
        DAQmx_CI_NumPossiblyInvalidSamps
        DAQmx_CI_DupCountPrevent
        DAQmx_CO_OutputType
        DAQmx_CO_Pulse_IdleState
        DAQmx_CO_Pulse_Term
        DAQmx_CO_Pulse_Time_Units
        DAQmx_CO_Pulse_HighTime
        DAQmx_CO_Pulse_LowTime
        DAQmx_CO_Pulse_Time_InitialDelay
        DAQmx_CO_Pulse_DutyCyc
        DAQmx_CO_Pulse_Freq_Units
        DAQmx_CO_Pulse_Freq
        DAQmx_CO_Pulse_Freq_InitialDelay
        DAQmx_CO_Pulse_HighTicks
        DAQmx_CO_Pulse_LowTicks
        DAQmx_CO_Pulse_Ticks_InitialDelay
        DAQmx_CO_CtrTimebaseSrc
        DAQmx_CO_CtrTimebaseRate
        DAQmx_CO_CtrTimebaseActiveEdge
        DAQmx_CO_Count
        DAQmx_CO_OutputState
        DAQmx_CO_AutoIncrCnt
        DAQmx_CO_CtrTimebaseMasterTimebaseDiv
        DAQmx_CO_PulseDone
    #Export Signal Attributes
    enum:
        DAQmx_Exported_AIConvClk_OutputTerm
        DAQmx_Exported_AIConvClk_Pulse_Polarity
        DAQmx_Exported_20MHzTimebase_OutputTerm
        DAQmx_Exported_SampClk_OutputBehavior
        DAQmx_Exported_SampClk_OutputTerm
        DAQmx_Exported_AdvTrig_OutputTerm
        DAQmx_Exported_AdvTrig_Pulse_Polarity
        DAQmx_Exported_AdvTrig_Pulse_WidthUnits
        DAQmx_Exported_AdvTrig_Pulse_Width
        DAQmx_Exported_RefTrig_OutputTerm
        DAQmx_Exported_StartTrig_OutputTerm
        DAQmx_Exported_AdvCmpltEvent_OutputTerm
        DAQmx_Exported_AdvCmpltEvent_Delay
        DAQmx_Exported_AdvCmpltEvent_Pulse_Polarity
        DAQmx_Exported_AdvCmpltEvent_Pulse_Width
        DAQmx_Exported_AIHoldCmpltEvent_OutputTerm
        DAQmx_Exported_AIHoldCmpltEvent_PulsePolarity
        DAQmx_Exported_ChangeDetectEvent_OutputTerm
        DAQmx_Exported_CtrOutEvent_OutputTerm
        DAQmx_Exported_CtrOutEvent_OutputBehavior
        DAQmx_Exported_CtrOutEvent_Pulse_Polarity
        DAQmx_Exported_CtrOutEvent_Toggle_IdleState
        DAQmx_Exported_WatchdogExpiredEvent_OutputTerm
    # Device Attributes
    enum:
        DAQmx_Dev_ProductType
        DAQmx_Dev_SerialNum
    # Read Attributes
    enum:
        DAQmx_Read_RelativeTo
        DAQmx_Read_Offset
        DAQmx_Read_ChannelsToRead
        DAQmx_Read_ReadAllAvailSamp
        DAQmx_Read_AutoStart
        DAQmx_Read_OverWrite
        DAQmx_Read_CurrReadPos
        DAQmx_Read_AvailSampPerChan
        DAQmx_Read_TotalSampPerChanAcquired
        DAQmx_Read_ChangeDetect_HasOverflowed
        DAQmx_Read_RawDataWidth
        DAQmx_Read_NumChans
        DAQmx_Read_DigitalLines_BytesPerChan
    # Switch channel Attributes
    enum:
        DAQmx_SwitchChan_Usage
        DAQmx_SwitchChan_MaxACCarryCurrent
        DAQmx_SwitchChan_MaxACSwitchCurrent
        DAQmx_SwitchChan_MaxACCarryPwr
        DAQmx_SwitchChan_MaxACSwitchPwr
        DAQmx_SwitchChan_MaxDCCarryCurrent
        DAQmx_SwitchChan_MaxDCSwitchCurrent
        DAQmx_SwitchChan_MaxDCCarryPwr
        DAQmx_SwitchChan_MaxDCSwitchPwr
        DAQmx_SwitchChan_MaxACVoltage
        DAQmx_SwitchChan_MaxDCVoltage
        DAQmx_SwitchChan_WireMode
        DAQmx_SwitchChan_Bandwidth
        DAQmx_SwitchChan_Impedance
    # Switch device attributes
    enum:
        DAQmx_SwitchDev_SettlingTime
        DAQmx_SwitchDev_AutoConnAnlgBus
        DAQmx_SwitchDev_Settled
        DAQmx_SwitchDev_RelayList
        DAQmx_SwitchDev_NumRelays
        DAQmx_SwitchDev_SwitchChanList
        DAQmx_SwitchDev_NumSwitchChans
        DAQmx_SwitchDev_NumRows
        DAQmx_SwitchDev_NumColumns
        DAQmx_SwitchDev_Topology
    # Switch scan attributes
    enum:
        DAQmx_SwitchScan_BreakMode
        DAQmx_SwitchScan_RepeatMode
        DAQmx_SwitchScan_WaitingForAdv
    # Scale attributes
    enum:
        DAQmx_Scale_Descr
        DAQmx_Scale_ScaledUnits
        DAQmx_Scale_PreScaledUnits
        DAQmx_Scale_Type
        DAQmx_Scale_Lin_Slope
        DAQmx_Scale_Lin_YIntercept
        DAQmx_Scale_Map_ScaledMax
        DAQmx_Scale_Map_PreScaledMax
        DAQmx_Scale_Map_ScaledMin
        DAQmx_Scale_Map_PreScaledMin
        DAQmx_Scale_Poly_ForwardCoeff
        DAQmx_Scale_Poly_ReverseCoeff
        DAQmx_Scale_Table_ScaledVals
        DAQmx_Scale_Table_PreScaledVals
    # System attributes
    enum:
        DAQmx_Sys_GlobalChans
        DAQmx_Sys_Scales
        DAQmx_Sys_Tasks
        DAQmx_Sys_DevNames
        DAQmx_Sys_NIDAQMajorVersion
        DAQmx_Sys_NIDAQMinorVersion
    # Task attributes
    enum:
        DAQmx_Task_Name
        DAQmx_Task_Channels
        DAQmx_Task_NumChans
        DAQmx_Task_Complete
    # Timing attributes
    enum:
        DAQmx_SampQuant_SampMode
        DAQmx_SampQuant_SampPerChan
        DAQmx_SampTimingType
        DAQmx_SampClk_Rate
        DAQmx_SampClk_Src
        DAQmx_SampClk_ActiveEdge
        DAQmx_SampClk_TimebaseDiv
        DAQmx_SampClk_Timebase_Rate
        DAQmx_SampClk_Timebase_Src
        DAQmx_SampClk_Timebase_ActiveEdge
        DAQmx_SampClk_Timebase_MasterTimebaseDiv
        DAQmx_ChangeDetect_DI_RisingEdgePhysicalChans
        DAQmx_ChangeDetect_DI_FallingEdgePhysicalChans
        DAQmx_OnDemand_SimultaneousAOEnable
        DAQmx_AIConv_Rate
        DAQmx_AIConv_Src
        DAQmx_AIConv_ActiveEdge
        DAQmx_AIConv_TimebaseDiv
        DAQmx_AIConv_Timebase_Src
        DAQmx_MasterTimebase_Rate
        DAQmx_MasterTimebase_Src
        DAQmx_DelayFromSampClk_DelayUnits
        DAQmx_DelayFromSampClk_Delay
    # Trigger attributes
    enum:
        DAQmx_StartTrig_Type
        DAQmx_DigEdge_StartTrig_Src
        DAQmx_DigEdge_StartTrig_Edge
        DAQmx_AnlgEdge_StartTrig_Src
        DAQmx_AnlgEdge_StartTrig_Slope
        DAQmx_AnlgEdge_StartTrig_Lvl
        DAQmx_AnlgEdge_StartTrig_Hyst
        DAQmx_AnlgWin_StartTrig_Src
        DAQmx_AnlgWin_StartTrig_When
        DAQmx_AnlgWin_StartTrig_Top
        DAQmx_AnlgWin_StartTrig_Btm
        DAQmx_StartTrig_Delay
        DAQmx_StartTrig_DelayUnits
        DAQmx_StartTrig_Retriggerable
        DAQmx_RefTrig_Type
        DAQmx_RefTrig_PretrigSamples
        DAQmx_DigEdge_RefTrig_Src
        DAQmx_DigEdge_RefTrig_Edge
        DAQmx_AnlgEdge_RefTrig_Src
        DAQmx_AnlgEdge_RefTrig_Slope
        DAQmx_AnlgEdge_RefTrig_Lvl
        DAQmx_AnlgEdge_RefTrig_Hyst
        DAQmx_AnlgWin_RefTrig_Src
        DAQmx_AnlgWin_RefTrig_When
        DAQmx_AnlgWin_RefTrig_Top
        DAQmx_AnlgWin_RefTrig_Btm
        DAQmx_AdvTrig_Type
        DAQmx_DigEdge_AdvTrig_Src
        DAQmx_DigEdge_AdvTrig_Edge
        DAQmx_PauseTrig_Type
        DAQmx_AnlgLvl_PauseTrig_Src
        DAQmx_AnlgLvl_PauseTrig_When
        DAQmx_AnlgLvl_PauseTrig_Lvl
        DAQmx_AnlgLvl_PauseTrig_Hyst
        DAQmx_AnlgWin_PauseTrig_Src
        DAQmx_AnlgWin_PauseTrig_When
        DAQmx_AnlgWin_PauseTrig_Top
        DAQmx_AnlgWin_PauseTrig_Btm
        DAQmx_DigLvl_PauseTrig_Src
        DAQmx_DigLvl_PauseTrig_When
        DAQmx_ArmStartTrig_Type
        DAQmx_DigEdge_ArmStartTrig_Src
        DAQmx_DigEdge_ArmStartTrig_Edge
    # Watchdog attibutes
    enum:
        DAQmx_Watchdog_Timeout
        DAQmx_WatchdogExpirTrig_Type
        DAQmx_DigEdge_WatchdogExpirTrig_Src
        DAQmx_DigEdge_WatchdogExpirTrig_Edge
        DAQmx_Watchdog_DO_ExpirState
        DAQmx_Watchdog_HasExpired
    # Write attributes
    enum:
        DAQmx_Write_RelativeTo
        DAQmx_Write_Offset
        DAQmx_Write_RegenMode
        DAQmx_Write_CurrWritePos
        DAQmx_Write_SpaceAvail
        DAQmx_Write_TotalSampPerChanGenerated
        DAQmx_Write_RawDataWidth
        DAQmx_Write_NumChans
        DAQmx_Write_DigitalLines_BytesPerChan

    #--------------------------------------------------------------------------
    # Non-Attribute Function Parameter Values
    #--------------------------------------------------------------------------

    # Values fot the Mode parameter of DAQmxTaskControl
    enum:
        DAQmx_Val_Task_Start
        DAQmx_Val_Task_Stop
        DAQmx_Val_Task_Verify
        DAQmx_Val_Task_Commit
        DAQmx_Val_Task_Reserve
        DAQmx_Val_Task_Unreserve
        DAQmx_Val_Task_Abort
    # Values for the Action parameter of DAQmxControlWatchdogTask
    enum:
        DAQmx_Val_ResetTimer
        DAQmx_Val_ClearExpiration
    # Values for the Line Grouping parameter of DAQmxCreateDIChan and DAQmxCreateDOChan
    enum:
        DAQmx_Val_ChanPerLine
        DAQmx_Val_ChanForAllLines
    # Values for the Fill Mode parameter of DAQmxReadAnalogF64, DAQmxReadBinaryI16, DAQmxReadBinaryU16, DAQmxReadDigitalU8, DAQmxReadDigitalU32, DAQmxReadDigitalLines
    # Values for the Data Layout parameter of DAQmxWriteAnalogF64, DAQmxWriteBinaryI16, DAQmxWriteDigitalU8, DAQmxWriteDigitalU32, DAQmxWriteDigitalLines
    enum:
        DAQmx_Val_GroupByChannel
        DAQmx_Val_GroupByScanNumber
    # Values for the Signal Modifiers parameter of DAQmxConnectTerms
    enum:
        DAQmx_Val_DoNotInvertPolarity
        DAQmx_Val_InvertPolarity
    # Values for the Action paramter of DAQmxCloseExtCal
    enum:
        DAQmx_Val_Action_Commit
        DAQmx_Val_Action_Cancel
    # Values for the Trigger ID parameter of DAQmxSendSoftwareTrigger
    enum:
        DAQmx_Val_AdvanceTrigger
    # Value set for the Signal ID parameter of DAQmxExportSignal
    enum:
        DAQmx_Val_AIConvertClock
        DAQmx_Val_20MHzTimebaseClock
        DAQmx_Val_SampleClock
        DAQmx_Val_AdvanceTrigger
        DAQmx_Val_ReferenceTrigger
        DAQmx_Val_StartTrigger
        DAQmx_Val_AdvCmpltEvent
        DAQmx_Val_AIHoldCmpltEvent
        DAQmx_Val_CounterOutputEvent
        DAQmx_Val_ChangeDetectionEvent
        DAQmx_Val_WDTExpiredEvent
    # Value set for the ActiveEdge parameter of DAQmxCfgSampClkTiming
    enum:
        DAQmx_Val_Rising
        DAQmx_Val_Falling
    # Value set SwitchPathType
    # Value set for the output Path Status parameter of DAQmxSwitchFindPath
    enum:
        DAQmx_Val_PathStatus_Available
        DAQmx_Val_PathStatus_AlreadyExists
        DAQmx_Val_PathStatus_Unsupported
        DAQmx_Val_PathStatus_ChannelInUse
        DAQmx_Val_PathStatus_SourceChannelConflict
        DAQmx_Val_PathStatus_ChannelReservedForRouting
    #Value set for the Units parameter of DAQmxCreateAIThrmcplChan, DAQmxCreateAIRTDChan, DAQmxCreateAIThrmstrChanIex, DAQmxCreateAIThrmstrChanVex and DAQmxCreateAITempBuiltInSensorChan
    enum:
        DAQmx_Val_DegC
        DAQmx_Val_DegF
        DAQmx_Val_Kelvins
        DAQmx_Val_DegR
    # Value set for the state parameter of DAQmxSetDigitalPowerUpStates
    enum:
        DAQmx_Val_High
        DAQmx_Val_Low
        DAQmx_Val_Tristate
    # Value set RelayPos
    # Value set for the state parameter of DAQmxSwitchGetSingleRelayPos and DAQmxSwitchGetMultiRelayPos
    enum:
        DAQmx_Val_Open
        DAQmx_Val_Closed
    #Value for the Terminal Config parameter of DAQmxCreateAIVoltageChan, DAQmxCreateAICurrentChan and DAQmxCreateAIVoltageChanWithExcit
    enum:
        DAQmx_Val_Cfg_Default
    # Value for the Timeout parameter of DAQmxWaitUntilTaskDone
    enum:
        DAQmx_Val_WaitInfinitely
    # Value for the Number of Samples per Channel parameter of DAQmxReadAnalogF64, DAQmxReadBinaryI16, DAQmxReadBinaryU16, DAQmxReadDigitalU8, DAQmxReadDigitalU32, DAQmxReadDigitalLines, DAQmxReadCounterF64, DAQmxReadCounterU32 and DAQmxReadRaw
    enum:
        DAQmx_Val_Auto

    #--------------------------------------------------------------------------
    # Attribute values
    #--------------------------------------------------------------------------

    # Values for DAQmx_AI_ACExcit_WireMode ***
    # Value set ACExcitWireMode ***
    enum:
        DAQmx_Val_4Wire
        DAQmx_Val_5Wire
    # Values for DAQmx_AI_MeasType ***
    # Value set AIMeasurementType ***
    enum:
        DAQmx_Val_Voltage
        DAQmx_Val_Current
        DAQmx_Val_Voltage_CustomWithExcitation
        DAQmx_Val_Freq_Voltage
        DAQmx_Val_Resistance
        DAQmx_Val_Temp_TC
        DAQmx_Val_Temp_Thrmstr
        DAQmx_Val_Temp_RTD
        DAQmx_Val_Temp_BuiltInSensor
        DAQmx_Val_Strain_Gage
        DAQmx_Val_Position_LVDT
        DAQmx_Val_Position_RVDT
        DAQmx_Val_Accelerometer
    # Values for DAQmx_AO_OutputType ***
    # Value set AOOutputChannelType ***
    enum:
        DAQmx_Val_Voltage
        DAQmx_Val_Current
    # Values for DAQmx_AI_Accel_SensitivityUnits ***
    # Value set AccelSensitivityUnits1 ***
    enum:
        DAQmx_Val_mVoltsPerG
        DAQmx_Val_VoltsPerG
    # Values for DAQmx_AI_Accel_Units ***
    # Value set AccelUnits2 ***
    enum:
        DAQmx_Val_AccelUnit_g
        DAQmx_Val_FromCustomScale
    # Values for DAQmx_SampQuant_SampMode ***
    # Value set AcquisitionType ***
    enum:
        DAQmx_Val_FiniteSamps
        DAQmx_Val_ContSamps
    # Values for DAQmx_AnlgLvl_PauseTrig_When ***
    # Value set ActiveLevel ***
    enum:
        DAQmx_Val_AboveLvl
        DAQmx_Val_BelowLvl
    # Values for DAQmx_AI_RVDT_Units ***
    # Value set AngleUnits1 ***
    enum:
        DAQmx_Val_Degrees
        DAQmx_Val_Radians
        DAQmx_Val_FromCustomScale
    # Values for DAQmx_CI_AngEncoder_Units ***
    # Value set AngleUnits2 ***
    enum:
        DAQmx_Val_Degrees
        DAQmx_Val_Radians
        DAQmx_Val_Ticks
        DAQmx_Val_FromCustomScale
    # Values for DAQmx_AI_AutoZeroMode ***
    # Value set AutoZeroType1 ***
    enum:
        DAQmx_Val_None
        DAQmx_Val_Once
    # Values for DAQmx_SwitchScan_BreakMode ***
    # Value set BreakMode ***
    enum:
        DAQmx_Val_NoAction
        DAQmx_Val_BreakBeforeMake
    # Values for DAQmx_AI_Bridge_Cfg ***
    # Value set BridgeConfiguration1 ***
    enum:
        DAQmx_Val_FullBridge
        DAQmx_Val_HalfBridge
        DAQmx_Val_QuarterBridge
        DAQmx_Val_NoBridge
    # Values for DAQmx_CI_MeasType
    # Value set CIMeasurementType
    enum:
        DAQmx_Val_CountEdges
        DAQmx_Val_Freq
        DAQmx_Val_Period
        DAQmx_Val_PulseWidth
        DAQmx_Val_SemiPeriod
        DAQmx_Val_Position_AngEncoder
        DAQmx_Val_Position_LinEncoder
        DAQmx_Val_TwoEdgeSep
    # Values for DAQmx_AI_Thrmcpl_CJCSrc
    # Value set CJCSource1
    enum:
        DAQmx_Val_BuiltIn
        DAQmx_Val_ConstVal
        DAQmx_Val_Chan
    # Values for DAQmx_CO_OutputType
    # Value set COOutputType
    enum:
        DAQmx_Val_Pulse_Time
        DAQmx_Val_Pulse_Freq
        DAQmx_Val_Pulse_Ticks
    # Values for DAQmx_ChanType
    # Value set ChannelType
    enum:
        DAQmx_Val_AI
        DAQmx_Val_AO
        DAQmx_Val_DI
        DAQmx_Val_DO
        DAQmx_Val_CI
        DAQmx_Val_CO
    # Values for DAQmx_CI_CountEdges_Dir
    # Value set CountDirection1
    enum:
        DAQmx_Val_CountUp
        DAQmx_Val_CountDown
        DAQmx_Val_ExtControlled
    # Values for DAQmx_CI_Freq_MeasMeth
    # Values for DAQmx_CI_Period_MeasMeth
    # Value set CounterFrequencyMethod
    enum:
        DAQmx_Val_LowFreq1Ctr
        DAQmx_Val_HighFreq2Ctr
        DAQmx_Val_LargeRng2Ctr
    # Values for DAQmx_AI_Coupling
    # Value set Coupling1
    enum:
        DAQmx_Val_AC
        DAQmx_Val_DC
        DAQmx_Val_GND
    # Values for DAQmx_AI_CurrentShunt_Loc
    # Value set CurrentShuntResistorLocation1
    enum:
        DAQmx_Val_Internal
        DAQmx_Val_External
    # Values for DAQmx_AI_Current_Units
    # Values for DAQmx_AO_Current_Units
    # Value set CurrentUnits1
    enum:
        DAQmx_Val_Amps
        DAQmx_Val_FromCustomScale
    # Values for DAQmx_AI_DataXferMech
    # Values for DAQmx_AO_DataXferMech
    # Values for DAQmx_CI_DataXferMech
    # Value set DataTransferMechanism
    enum:
        DAQmx_Val_DMA
        DAQmx_Val_Interrupts
        DAQmx_Val_ProgrammedIO
    # Values for DAQmx_Watchdog_DO_ExpirState
    # Value set DigitalLineState
    enum:
        DAQmx_Val_High
        DAQmx_Val_Low
        DAQmx_Val_Tristate
        DAQmx_Val_NoChange
    # Values for DAQmx_StartTrig_DelayUnits
    # Value set DigitalWidthUnits1
    enum:
        DAQmx_Val_SampClkPeriods
        DAQmx_Val_Seconds
        DAQmx_Val_Ticks
    # Values for DAQmx_DelayFromSampClk_DelayUnits
    # Value set DigitalWidthUnits2
    enum:
        DAQmx_Val_Seconds
        DAQmx_Val_Ticks
    # Values for DAQmx_Exported_AdvTrig_Pulse_WidthUnits
    # Value set DigitalWidthUnits3
    enum:
        DAQmx_Val_Seconds
    # Values for DAQmx_CI_Freq_StartingEdge
    # Values for DAQmx_CI_Period_StartingEdge
    # Values for DAQmx_CI_CountEdges_ActiveEdge
    # Values for DAQmx_CI_PulseWidth_StartingEdge
    # Values for DAQmx_CI_TwoEdgeSep_FirstEdge
    # Values for DAQmx_CI_TwoEdgeSep_SecondEdge
    # Values for DAQmx_CI_CtrTimebaseActiveEdge
    # Values for DAQmx_CO_CtrTimebaseActiveEdge
    # Values for DAQmx_SampClk_ActiveEdge
    # Values for DAQmx_SampClk_Timebase_ActiveEdge
    # Values for DAQmx_AIConv_ActiveEdge
    # Values for DAQmx_DigEdge_StartTrig_Edge
    # Values for DAQmx_DigEdge_RefTrig_Edge
    # Values for DAQmx_DigEdge_AdvTrig_Edge
    # Values for DAQmx_DigEdge_ArmStartTrig_Edge
    # Values for DAQmx_DigEdge_WatchdogExpirTrig_Edge
    # Value set Edge1
    enum:
        DAQmx_Val_Rising
        DAQmx_Val_Falling
    # Values for DAQmx_CI_Encoder_DecodingType
    # Value set EncoderType2
    enum:
        DAQmx_Val_X1
        DAQmx_Val_X2
        DAQmx_Val_X4
        DAQmx_Val_TwoPulseCounting
    # Values for DAQmx_CI_Encoder_ZIndexPhase
    # Value set EncoderZIndexPhase1
    enum:
        DAQmx_Val_AHighBHigh
        DAQmx_Val_AHighBLow
        DAQmx_Val_ALowBHigh
        DAQmx_Val_ALowBLow
    # Values for DAQmx_AI_Excit_DCorAC
    # Value set ExcitationDCorAC
    enum:
        DAQmx_Val_DC
        DAQmx_Val_AC
    # Values for DAQmx_AI_Excit_Src
    # Value set ExcitationSource
    enum:
        DAQmx_Val_Internal
        DAQmx_Val_External
        DAQmx_Val_None
    # Values for DAQmx_AI_Excit_VoltageOrCurrent
    # Value set ExcitationVoltageOrCurrent
    enum:
        DAQmx_Val_Voltage
        DAQmx_Val_Current
    # Values for DAQmx_Exported_CtrOutEvent_OutputBehavior
    # Value set ExportActions2
    enum:
        DAQmx_Val_Pulse
        DAQmx_Val_Toggle
    # Values for DAQmx_Exported_SampClk_OutputBehavior
    # Value set ExportActions3
    enum:
        DAQmx_Val_Pulse
        DAQmx_Val_Lvl
    # Values for DAQmx_AI_Freq_Units
    # Value set FrequencyUnits
    enum:
        DAQmx_Val_Hz
        DAQmx_Val_FromCustomScale
    # Values for DAQmx_CO_Pulse_Freq_Units
    # Value set FrequencyUnits2
    enum:
        DAQmx_Val_Hz
    # Values for DAQmx_CI_Freq_Units
    # Value set FrequencyUnits3
    enum:
        DAQmx_Val_Hz
        DAQmx_Val_Ticks
        DAQmx_Val_FromCustomScale
    # Values for DAQmx_AI_DataXferReqCond
    # Value set InputDataTransferCondition
    enum:
        DAQmx_Val_OnBrdMemMoreThanHalfFull
        DAQmx_Val_OnBrdMemNotEmpty
    # Values for DAQmx_AI_TermCfg
    # Value set InputTermCfg
    enum:
        DAQmx_Val_RSE
        DAQmx_Val_NRSE
        DAQmx_Val_Diff
    # Values for DAQmx_AI_LVDT_SensitivityUnits
    # Value set LVDTSensitivityUnits1
    enum:
        DAQmx_Val_mVoltsPerVoltPerMillimeter
        DAQmx_Val_mVoltsPerVoltPerMilliInch
    # Values for DAQmx_AI_LVDT_Units
    # Value set LengthUnits2
    enum:
        DAQmx_Val_Meters
        DAQmx_Val_Inches
        DAQmx_Val_FromCustomScale
    # Values for DAQmx_CI_LinEncoder_Units
    # Value set LengthUnits3
    enum:
        DAQmx_Val_Meters
        DAQmx_Val_Inches
        DAQmx_Val_Ticks
        DAQmx_Val_FromCustomScale
    # Values for DAQmx_CI_OutputState
    # Values for DAQmx_CO_Pulse_IdleState
    # Values for DAQmx_CO_OutputState
    # Values for DAQmx_Exported_CtrOutEvent_Toggle_IdleState
    # Values for DAQmx_DigLvl_PauseTrig_When
    # Value set Level1
    enum:
        DAQmx_Val_High
        DAQmx_Val_Low
    # Values for DAQmx_AIConv_Timebase_Src
    # Value set MIOAIConvertTbSrc
    enum:
        DAQmx_Val_SameAsSampTimebase
        DAQmx_Val_SameAsMasterTimebase
    # Values for DAQmx_AO_DataXferReqCond
    # Value set OutputDataTransferCondition
    enum:
        DAQmx_Val_OnBrdMemEmpty
        DAQmx_Val_OnBrdMemHalfFullOrLess
        DAQmx_Val_OnBrdMemNotFull
    # Values for DAQmx_Read_OverWrite
    # Value set OverwriteMode1
    enum:
        DAQmx_Val_OverwriteUnreadSamps
        DAQmx_Val_DoNotOverwriteUnreadSamps
    # Values for DAQmx_Exported_AIConvClk_Pulse_Polarity
    # Values for DAQmx_Exported_AdvTrig_Pulse_Polarity
    # Values for DAQmx_Exported_AdvCmpltEvent_Pulse_Polarity
    # Values for DAQmx_Exported_AIHoldCmpltEvent_PulsePolarity
    # Values for DAQmx_Exported_CtrOutEvent_Pulse_Polarity
    # Value set Polarity2
    enum:
        DAQmx_Val_ActiveHigh
        DAQmx_Val_ActiveLow
    # Values for DAQmx_AI_RTD_Type
    # Value set RTDType1
    enum:
        DAQmx_Val_Pt3750
        DAQmx_Val_Pt3851
        DAQmx_Val_Pt3911
        DAQmx_Val_Pt3916
        DAQmx_Val_Pt3920
        DAQmx_Val_Pt3928
        DAQmx_Val_Custom
    # Values for DAQmx_AI_RVDT_SensitivityUnits
    # Value set RVDTSensitivityUnits1
    enum:
        DAQmx_Val_mVoltsPerVoltPerDegree
        DAQmx_Val_mVoltsPerVoltPerRadian
    # Values for DAQmx_Read_RelativeTo
    # Value set ReadRelativeTo
    enum:
        DAQmx_Val_FirstSample
        DAQmx_Val_CurrReadPos
        DAQmx_Val_RefTrig
        DAQmx_Val_FirstPretrigSamp
        DAQmx_Val_MostRecentSamp
    # Values for DAQmx_Write_RegenMode
    # Value set RegenerationMode1
    enum:
        DAQmx_Val_AllowRegen
        DAQmx_Val_DoNotAllowRegen
    # Values for DAQmx_AI_ResistanceCfg
    # Value set ResistanceConfiguration
    enum:
        DAQmx_Val_2Wire
        DAQmx_Val_3Wire
        DAQmx_Val_4Wire
    # Values for DAQmx_AI_Resistance_Units
    # Value set ResistanceUnits1
    enum:
        DAQmx_Val_Ohms
        DAQmx_Val_FromCustomScale
    # Values for DAQmx_AI_ResolutionUnits
    # Values for DAQmx_AO_ResolutionUnits
    # Value set ResolutionType1
    enum:
        DAQmx_Val_Bits
    # Values for DAQmx_SampTimingType
    # Value set SampleTimingType
    enum:
        DAQmx_Val_SampClk
        DAQmx_Val_Handshake
        DAQmx_Val_Implicit
        DAQmx_Val_OnDemand
        DAQmx_Val_ChangeDetection
    # Values for DAQmx_Scale_Type
    # Value set ScaleType
    enum:
        DAQmx_Val_Linear
        DAQmx_Val_MapRanges
        DAQmx_Val_Polynomial
        DAQmx_Val_Table
    # Values for DAQmx_AI_Bridge_ShuntCal_Select
    # Value set ShuntCalSelect
    enum:
        DAQmx_Val_A
        DAQmx_Val_B
        DAQmx_Val_AandB
    # Values for DAQmx_AnlgEdge_StartTrig_Slope
    # Values for DAQmx_AnlgEdge_RefTrig_Slope
    # Value set Slope1
    enum:
        DAQmx_Val_RisingSlope
        DAQmx_Val_FallingSlope
    # Values for DAQmx_AI_Lowpass_SwitchCap_ClkSrc
    # Values for DAQmx_AO_DAC_Ref_Src
    # Value set SourceSelection
    enum:
        DAQmx_Val_Internal
        DAQmx_Val_External
    # Values for DAQmx_AI_StrainGage_Cfg
    # Value set StrainGageBridgeType1
    enum:
        DAQmx_Val_FullBridgeI
        DAQmx_Val_FullBridgeII
        DAQmx_Val_FullBridgeIII
        DAQmx_Val_HalfBridgeI
        DAQmx_Val_HalfBridgeII
        DAQmx_Val_QuarterBridgeI
        DAQmx_Val_QuarterBridgeII
    # Values for DAQmx_AI_Strain_Units
    # Value set StrainUnits1
    enum:
        DAQmx_Val_Strain
        DAQmx_Val_FromCustomScale
    # Values for DAQmx_SwitchScan_RepeatMode
    # Value set SwitchScanRepeatMode
    enum:
        DAQmx_Val_Finite
        DAQmx_Val_Cont
    # Values for DAQmx_SwitchChan_Usage
    # Value set SwitchUsageTypes
    enum:
        DAQmx_Val_Source
        DAQmx_Val_Load
        DAQmx_Val_ReservedForRouting
    # Values for DAQmx_AI_Temp_Units
    # Value set TemperatureUnits1
    enum:
        DAQmx_Val_DegC
        DAQmx_Val_DegF
        DAQmx_Val_Kelvins
        DAQmx_Val_DegR
        DAQmx_Val_FromCustomScale
    # Values for DAQmx_AI_Thrmcpl_Type
    # Value set ThermocoupleType1
    enum:
        DAQmx_Val_J_Type_TC
        DAQmx_Val_K_Type_TC
        DAQmx_Val_N_Type_TC
        DAQmx_Val_R_Type_TC
        DAQmx_Val_S_Type_TC
        DAQmx_Val_T_Type_TC
        DAQmx_Val_B_Type_TC
        DAQmx_Val_E_Type_TC
    # Values for DAQmx_CO_Pulse_Time_Units
    # Value set TimeUnits2
    enum:
        DAQmx_Val_Seconds
    # Values for DAQmx_CI_Period_Units
    # Values for DAQmx_CI_PulseWidth_Units
    # Values for DAQmx_CI_TwoEdgeSep_Units
    # Values for DAQmx_CI_SemiPeriod_Units
    # Value set TimeUnits3
    enum:
        DAQmx_Val_Seconds
        DAQmx_Val_Ticks
        DAQmx_Val_FromCustomScale
    # Values for DAQmx_RefTrig_Type
    # Value set TriggerType1
    enum:
        DAQmx_Val_AnlgEdge
        DAQmx_Val_DigEdge
        DAQmx_Val_AnlgWin
        DAQmx_Val_None
    # Values for DAQmx_ArmStartTrig_Type
    # Values for DAQmx_WatchdogExpirTrig_Type
    # Value set TriggerType4
    enum:
        DAQmx_Val_DigEdge
        DAQmx_Val_None
    # Values for DAQmx_AdvTrig_Type
    # Value set TriggerType5
    enum:
        DAQmx_Val_DigEdge
        DAQmx_Val_Software
        DAQmx_Val_None
    # Values for DAQmx_PauseTrig_Type
    # Value set TriggerType6
    enum:
        DAQmx_Val_AnlgLvl
        DAQmx_Val_AnlgWin
        DAQmx_Val_DigLvl
        DAQmx_Val_None
    # Values for DAQmx_StartTrig_Type
    # Value set TriggerType8
    enum:
        DAQmx_Val_AnlgEdge
        DAQmx_Val_DigEdge
        DAQmx_Val_AnlgWin
        DAQmx_Val_None
    # Values for DAQmx_Scale_PreScaledUnits
    # Value set UnitsPreScaled
    enum:
        DAQmx_Val_Volts
        DAQmx_Val_Amps
        DAQmx_Val_DegF
        DAQmx_Val_DegC
        DAQmx_Val_DegR
        DAQmx_Val_Kelvins
        DAQmx_Val_Strain
        DAQmx_Val_Ohms
        DAQmx_Val_Hz
        DAQmx_Val_Seconds
        DAQmx_Val_Meters
        DAQmx_Val_Inches
        DAQmx_Val_Degrees
        DAQmx_Val_Radians
        DAQmx_Val_g
    # Values for DAQmx_AI_Voltage_Units
    # Value set VoltageUnits1
    enum:
        DAQmx_Val_Volts
        DAQmx_Val_FromCustomScale
    # Values for DAQmx_AO_Voltage_Units
    # Value set VoltageUnits2
    enum:
        DAQmx_Val_Volts
        DAQmx_Val_FromCustomScale
    # Values for DAQmx_AnlgWin_StartTrig_When
    # Values for DAQmx_AnlgWin_RefTrig_When
    # Value set WindowTriggerCondition1
    enum:
        DAQmx_Val_EnteringWin
        DAQmx_Val_LeavingWin
    # Values for DAQmx_AnlgWin_PauseTrig_When
    # Value set WindowTriggerCondition2
    enum:
        DAQmx_Val_InsideWin
        DAQmx_Val_OutsideWin
    # Values for DAQmx_Write_RelativeTo
    # Value set WriteRelativeTo
    enum:
        DAQmx_Val_FirstSample
        DAQmx_Val_CurrWritePos

    #--------------------------------------------------------------------------
    # Error Codes
    #--------------------------------------------------------------------------

    enum:
        DAQmxSuccess
    enum:
        DAQmxErrorInvalidInstallation
        DAQmxErrorRefTrigMasterSessionUnavailable
        DAQmxErrorRouteFailedBecauseWatchdogExpired
        DAQmxErrorDeviceShutDownDueToHighTemp
        DAQmxErrorNoMemMapWhenHWTimedSinglePoint
        DAQmxErrorWriteFailedBecauseWatchdogExpired
        DAQmxErrorDifftInternalAIInputSrcs
        DAQmxErrorDifftAIInputSrcInOneChanGroup
        DAQmxErrorInternalAIInputSrcInMultChanGroups
        DAQmxErrorSwitchOpFailedDueToPrevError
        DAQmxErrorWroteMultiSampsUsingSingleSampWrite
        DAQmxErrorMismatchedInputArraySizes
        DAQmxErrorCantExceedRelayDriveLimit
        DAQmxErrorDACRngLowNotEqualToMinusRefVal
        DAQmxErrorCantAllowConnectDACToGnd
        DAQmxErrorWatchdogTimeoutOutOfRangeAndNotSpecialVal
        DAQmxErrorNoWatchdogOutputOnPortReservedForInput
        DAQmxErrorNoInputOnPortCfgdForWatchdogOutput
        DAQmxErrorWatchdogExpirationStateNotEqualForLinesInPort
        DAQmxErrorCannotPerformOpWhenTaskNotReserved
        DAQmxErrorPowerupStateNotSupported
        DAQmxErrorWatchdogTimerNotSupported
        DAQmxErrorOpNotSupportedWhenRefClkSrcNone
        DAQmxErrorSampClkRateUnavailable
        DAQmxErrorPrptyGetSpecdSingleActiveChanFailedDueToDifftVals
        DAQmxErrorPrptyGetImpliedActiveChanFailedDueToDifftVals
        DAQmxErrorPrptyGetSpecdActiveChanFailedDueToDifftVals
        DAQmxErrorNoRegenWhenUsingBrdMem
        DAQmxErrorNonbufferedReadMoreThanSampsPerChan
        DAQmxErrorWatchdogExpirationTristateNotSpecdForEntirePort
        DAQmxErrorPowerupTristateNotSpecdForEntirePort
        DAQmxErrorPowerupStateNotSpecdForEntirePort
        DAQmxErrorCantSetWatchdogExpirationOnDigInChan
        DAQmxErrorCantSetPowerupStateOnDigInChan
        DAQmxErrorPhysChanNotInTask
        DAQmxErrorPhysChanDevNotInTask
        DAQmxErrorDigInputNotSupported
        DAQmxErrorDigFilterIntervalNotEqualForLines
        DAQmxErrorDigFilterIntervalAlreadyCfgd
        DAQmxErrorCantResetExpiredWatchdog
        DAQmxErrorActiveChanTooManyLinesSpecdWhenGettingPrpty
        DAQmxErrorActiveChanNotSpecdWhenGetting1LinePrpty
        DAQmxErrorDigPrptyCannotBeSetPerLine
        DAQmxErrorSendAdvCmpltAfterWaitForTrigInScanlist
        DAQmxErrorDisconnectionRequiredInScanlist
        DAQmxErrorTwoWaitForTrigsAfterConnectionInScanlist
        DAQmxErrorActionSeparatorRequiredAfterBreakingConnectionInScanlist
        DAQmxErrorConnectionInScanlistMustWaitForTrig
        DAQmxErrorActionNotSupportedTaskNotWatchdog
        DAQmxErrorWfmNameSameAsScriptName
        DAQmxErrorScriptNameSameAsWfmName
        DAQmxErrorDSFStopClock
        DAQmxErrorDSFReadyForStartClock
        DAQmxErrorWriteOffsetNotMultOfIncr
        DAQmxErrorDifferentPrptyValsNotSupportedOnDev
        DAQmxErrorRefAndPauseTrigConfigured
        DAQmxErrorFailedToEnableHighSpeedInputClock
        DAQmxErrorEmptyPhysChanInPowerUpStatesArray
        DAQmxErrorActivePhysChanTooManyLinesSpecdWhenGettingPrpty
        DAQmxErrorActivePhysChanNotSpecdWhenGetting1LinePrpty
        DAQmxErrorPXIDevTempCausedShutDown
        DAQmxErrorInvalidNumSampsToWrite
        DAQmxErrorOutputFIFOUnderflow2
        DAQmxErrorRepeatedAIPhysicalChan
        DAQmxErrorMultScanOpsInOneChassis
        DAQmxErrorInvalidAIChanOrder
        DAQmxErrorReversePowerProtectionActivated
        DAQmxErrorInvalidAsynOpHandle
        DAQmxErrorFailedToEnableHighSpeedOutput
        DAQmxErrorCannotReadPastEndOfRecord
        DAQmxErrorAcqStoppedToPreventInputBufferOverwriteOneDataXferMech
        DAQmxErrorZeroBasedChanIndexInvalid
        DAQmxErrorNoChansOfGivenTypeInTask
        DAQmxErrorSampClkSrcInvalidForOutputValidForInput
        DAQmxErrorOutputBufSizeTooSmallToStartGen
        DAQmxErrorInputBufSizeTooSmallToStartAcq
        DAQmxErrorExportTwoSignalsOnSameTerminal
        DAQmxErrorChanIndexInvalid
        DAQmxErrorRangeSyntaxNumberTooBig
        DAQmxErrorNULLPtr
        DAQmxErrorScaledMinEqualMax
        DAQmxErrorPreScaledMinEqualMax
        DAQmxErrorPropertyNotSupportedForScaleType
        DAQmxErrorChannelNameGenerationNumberTooBig
        DAQmxErrorRepeatedNumberInScaledValues
        DAQmxErrorRepeatedNumberInPreScaledValues
        DAQmxErrorLinesAlreadyReservedForOutput
        DAQmxErrorSwitchOperationChansSpanMultipleDevsInList
        DAQmxErrorInvalidIDInListAtBeginningOfSwitchOperation
        DAQmxErrorMStudioInvalidPolyDirection
        DAQmxErrorMStudioPropertyGetWhileTaskNotVerified
        DAQmxErrorRangeWithTooManyObjects
        DAQmxErrorCppDotNetAPINegativeBufferSize
        DAQmxErrorCppCantRemoveInvalidEventHandler
        DAQmxErrorCppCantRemoveEventHandlerTwice
        DAQmxErrorCppCantRemoveOtherObjectsEventHandler
        DAQmxErrorDigLinesReservedOrUnavailable
        DAQmxErrorDSFFailedToResetStream
        DAQmxErrorDSFReadyForOutputNotAsserted
        DAQmxErrorSampToWritePerChanNotMultipleOfIncr
        DAQmxErrorAOPropertiesCauseVoltageBelowMin
        DAQmxErrorAOPropertiesCauseVoltageOverMax
        DAQmxErrorPropertyNotSupportedWhenRefClkSrcNone
        DAQmxErrorAIMaxTooSmall
        DAQmxErrorAIMaxTooLarge
        DAQmxErrorAIMinTooSmall
        DAQmxErrorAIMinTooLarge
        DAQmxErrorBuiltInCJCSrcNotSupported
        DAQmxErrorTooManyPostTrigSampsPerChan
        DAQmxErrorTrigLineNotFoundSingleDevRoute
        DAQmxErrorDifferentInternalAIInputSources
        DAQmxErrorDifferentAIInputSrcInOneChanGroup
        DAQmxErrorInternalAIInputSrcInMultipleChanGroups
        DAQmxErrorCAPIChanIndexInvalid
        DAQmxErrorCollectionDoesNotMatchChanType
        DAQmxErrorOutputCantStartChangedRegenerationMode
        DAQmxErrorOutputCantStartChangedBufferSize
        DAQmxErrorChanSizeTooBigForU32PortWrite
        DAQmxErrorChanSizeTooBigForU8PortWrite
        DAQmxErrorChanSizeTooBigForU32PortRead
        DAQmxErrorChanSizeTooBigForU8PortRead
        DAQmxErrorInvalidDigDataWrite
        DAQmxErrorInvalidAODataWrite
        DAQmxErrorWaitUntilDoneDoesNotIndicateDone
        DAQmxErrorMultiChanTypesInTask
        DAQmxErrorMultiDevsInTask
        DAQmxErrorCannotSetPropertyWhenTaskRunning
        DAQmxErrorCannotGetPropertyWhenTaskNotCommittedOrRunning
        DAQmxErrorLeadingUnderscoreInString
        DAQmxErrorTrailingSpaceInString
        DAQmxErrorLeadingSpaceInString
        DAQmxErrorInvalidCharInString
        DAQmxErrorDLLBecameUnlocked
        DAQmxErrorDLLLock
        DAQmxErrorSelfCalConstsInvalid
        DAQmxErrorInvalidTrigCouplingExceptForExtTrigChan
        DAQmxErrorWriteFailsBufferSizeAutoConfigured
        DAQmxErrorExtCalAdjustExtRefVoltageFailed
        DAQmxErrorSelfCalFailedExtNoiseOrRefVoltageOutOfCal
        DAQmxErrorExtCalTemperatureNotDAQmx
        DAQmxErrorExtCalDateTimeNotDAQmx
        DAQmxErrorSelfCalTemperatureNotDAQmx
        DAQmxErrorSelfCalDateTimeNotDAQmx
        DAQmxErrorDACRefValNotSet
        DAQmxErrorAnalogMultiSampWriteNotSupported
        DAQmxErrorInvalidActionInControlTask
        DAQmxErrorPolyCoeffsInconsistent
        DAQmxErrorSensorValTooLow
        DAQmxErrorSensorValTooHigh
        DAQmxErrorWaveformNameTooLong
        DAQmxErrorIdentifierTooLongInScript
        DAQmxErrorUnexpectedIDFollowingSwitchChanName
        DAQmxErrorRelayNameNotSpecifiedInList
        DAQmxErrorUnexpectedIDFollowingRelayNameInList
        DAQmxErrorUnexpectedIDFollowingSwitchOpInList
        DAQmxErrorInvalidLineGrouping
        DAQmxErrorCtrMinMax
        DAQmxErrorWriteChanTypeMismatch
        DAQmxErrorReadChanTypeMismatch
        DAQmxErrorWriteNumChansMismatch
        DAQmxErrorOneChanReadForMultiChanTask
        DAQmxErrorCannotSelfCalDuringExtCal
        DAQmxErrorMeasCalAdjustOscillatorPhaseDAC
        DAQmxErrorInvalidCalConstCalADCAdjustment
        DAQmxErrorInvalidCalConstOscillatorFreqDACValue
        DAQmxErrorInvalidCalConstOscillatorPhaseDACValue
        DAQmxErrorInvalidCalConstOffsetDACValue
        DAQmxErrorInvalidCalConstGainDACValue
        DAQmxErrorInvalidNumCalADCReadsToAverage
        DAQmxErrorInvalidCfgCalAdjustDirectPathOutputImpedance
        DAQmxErrorInvalidCfgCalAdjustMainPathOutputImpedance
        DAQmxErrorInvalidCfgCalAdjustMainPathPostAmpGainAndOffset
        DAQmxErrorInvalidCfgCalAdjustMainPathPreAmpGain
        DAQmxErrorInvalidCfgCalAdjustMainPreAmpOffset
        DAQmxErrorMeasCalAdjustCalADC
        DAQmxErrorMeasCalAdjustOscillatorFrequency
        DAQmxErrorMeasCalAdjustDirectPathOutputImpedance
        DAQmxErrorMeasCalAdjustMainPathOutputImpedance
        DAQmxErrorMeasCalAdjustDirectPathGain
        DAQmxErrorMeasCalAdjustMainPathPostAmpGainAndOffset
        DAQmxErrorMeasCalAdjustMainPathPreAmpGain
        DAQmxErrorMeasCalAdjustMainPathPreAmpOffset
        DAQmxErrorInvalidDateTimeInEEPROM
        DAQmxErrorUnableToLocateErrorResources
        DAQmxErrorDotNetAPINotUnsigned32BitNumber
        DAQmxErrorInvalidRangeOfObjectsSyntaxInString
        DAQmxErrorAttemptToEnableLineNotPreviouslyDisabled
        DAQmxErrorInvalidCharInPattern
        DAQmxErrorIntermediateBufferFull
        DAQmxErrorLoadTaskFailsBecauseNoTimingOnDev
        DAQmxErrorCAPIReservedParamNotNULLNorEmpty
        DAQmxErrorCAPIReservedParamNotNULL
        DAQmxErrorCAPIReservedParamNotZero
        DAQmxErrorSampleValueOutOfRange
        DAQmxErrorChanAlreadyInTask
        DAQmxErrorVirtualChanDoesNotExist
        DAQmxErrorChanNotInTask
        DAQmxErrorTaskNotInDataNeighborhood
        DAQmxErrorCantSaveTaskWithoutReplace
        DAQmxErrorCantSaveChanWithoutReplace
        DAQmxErrorDevNotInTask
        DAQmxErrorDevAlreadyInTask
        DAQmxErrorCanNotPerformOpWhileTaskRunning
        DAQmxErrorCanNotPerformOpWhenNoChansInTask
        DAQmxErrorCanNotPerformOpWhenNoDevInTask
        DAQmxErrorCannotPerformOpWhenTaskNotRunning
        DAQmxErrorOperationTimedOut
        DAQmxErrorCannotReadWhenAutoStartFalseAndTaskNotRunningOrCommitted
        DAQmxErrorCannotWriteWhenAutoStartFalseAndTaskNotRunningOrCommitted
        DAQmxErrorTaskVersionNew
        DAQmxErrorChanVersionNew
        DAQmxErrorEmptyString
        DAQmxErrorChannelSizeTooBigForPortReadType
        DAQmxErrorChannelSizeTooBigForPortWriteType
        DAQmxErrorExpectedNumberOfChannelsVerificationFailed
        DAQmxErrorNumLinesMismatchInReadOrWrite
        DAQmxErrorOutputBufferEmpty
        DAQmxErrorInvalidChanName
        DAQmxErrorReadNoInputChansInTask
        DAQmxErrorWriteNoOutputChansInTask
        DAQmxErrorPropertyNotSupportedNotInputTask
        DAQmxErrorPropertyNotSupportedNotOutputTask
        DAQmxErrorGetPropertyNotInputBufferedTask
        DAQmxErrorGetPropertyNotOutputBufferedTask
        DAQmxErrorInvalidTimeoutVal
        DAQmxErrorAttributeNotSupportedInTaskContext
        DAQmxErrorAttributeNotQueryableUnlessTaskIsCommitted
        DAQmxErrorAttributeNotSettableWhenTaskIsRunning
        DAQmxErrorDACRngLowNotMinusRefValNorZero
        DAQmxErrorDACRngHighNotEqualRefVal
        DAQmxErrorUnitsNotFromCustomScale
        DAQmxErrorInvalidVoltageReadingDuringExtCal
        DAQmxErrorCalFunctionNotSupported
        DAQmxErrorInvalidPhysicalChanForCal
        DAQmxErrorExtCalNotComplete
        DAQmxErrorCantSyncToExtStimulusFreqDuringCal
        DAQmxErrorUnableToDetectExtStimulusFreqDuringCal
        DAQmxErrorInvalidCloseAction
        DAQmxErrorExtCalFunctionOutsideExtCalSession
        DAQmxErrorInvalidCalArea
        DAQmxErrorExtCalConstsInvalid
        DAQmxErrorStartTrigDelayWithExtSampClk
        DAQmxErrorDelayFromSampClkWithExtConv
        DAQmxErrorFewerThan2PreScaledVals
        DAQmxErrorFewerThan2ScaledValues
        DAQmxErrorPhysChanOutputType
        DAQmxErrorPhysChanMeasType
        DAQmxErrorInvalidPhysChanType
        DAQmxErrorLabVIEWEmptyTaskOrChans
        DAQmxErrorLabVIEWInvalidTaskOrChans
        DAQmxErrorInvalidRefClkRate
        DAQmxErrorInvalidExtTrigImpedance
        DAQmxErrorHystTrigLevelAIMax
        DAQmxErrorLineNumIncompatibleWithVideoSignalFormat
        DAQmxErrorTrigWindowAIMinAIMaxCombo
        DAQmxErrorTrigAIMinAIMax
        DAQmxErrorHystTrigLevelAIMin
        DAQmxErrorInvalidSampRateConsiderRIS
        DAQmxErrorInvalidReadPosDuringRIS
        DAQmxErrorImmedTrigDuringRISMode
        DAQmxErrorTDCNotEnabledDuringRISMode
        DAQmxErrorMultiRecWithRIS
        DAQmxErrorInvalidRefClkSrc
        DAQmxErrorInvalidSampClkSrc
        DAQmxErrorInsufficientOnBoardMemForNumRecsAndSamps
        DAQmxErrorInvalidAIAttenuation
        DAQmxErrorACCouplingNotAllowedWith50OhmImpedance
        DAQmxErrorInvalidRecordNum
        DAQmxErrorZeroSlopeLinearScale
        DAQmxErrorZeroReversePolyScaleCoeffs
        DAQmxErrorZeroForwardPolyScaleCoeffs
        DAQmxErrorNoReversePolyScaleCoeffs
        DAQmxErrorNoForwardPolyScaleCoeffs
        DAQmxErrorNoPolyScaleCoeffs
        DAQmxErrorReversePolyOrderLessThanNumPtsToCompute
        DAQmxErrorReversePolyOrderNotPositive
        DAQmxErrorNumPtsToComputeNotPositive
        DAQmxErrorWaveformLengthNotMultipleOfIncr
        DAQmxErrorCAPINoExtendedErrorInfoAvailable
        DAQmxErrorCVIFunctionNotFoundInDAQmxDLL
        DAQmxErrorCVIFailedToLoadDAQmxDLL
        DAQmxErrorNoCommonTrigLineForImmedRoute
        DAQmxErrorNoCommonTrigLineForTaskRoute
        DAQmxErrorF64PrptyValNotUnsignedInt
        DAQmxErrorRegisterNotWritable
        DAQmxErrorInvalidOutputVoltageAtSampClkRate
        DAQmxErrorStrobePhaseShiftDCMBecameUnlocked
        DAQmxErrorDrivePhaseShiftDCMBecameUnlocked
        DAQmxErrorClkOutPhaseShiftDCMBecameUnlocked
        DAQmxErrorOutputBoardClkDCMBecameUnlocked
        DAQmxErrorInputBoardClkDCMBecameUnlocked
        DAQmxErrorInternalClkDCMBecameUnlocked
        DAQmxErrorDCMLock
        DAQmxErrorDataLineReservedForDynamicOutput
        DAQmxErrorInvalidRefClkSrcGivenSampClkSrc
        DAQmxErrorNoPatternMatcherAvailable
        DAQmxErrorInvalidDelaySampRateBelowPhaseShiftDCMThresh
        DAQmxErrorStrainGageCalibration
        DAQmxErrorInvalidExtClockFreqAndDivCombo
        DAQmxErrorCustomScaleDoesNotExist
        DAQmxErrorOnlyFrontEndChanOpsDuringScan
        DAQmxErrorInvalidOptionForDigitalPortChannel
        DAQmxErrorUnsupportedSignalTypeExportSignal
        DAQmxErrorInvalidSignalTypeExportSignal
        DAQmxErrorUnsupportedTrigTypeSendsSWTrig
        DAQmxErrorInvalidTrigTypeSendsSWTrig
        DAQmxErrorRepeatedPhysicalChan
        DAQmxErrorResourcesInUseForRouteInTask
        DAQmxErrorResourcesInUseForRoute
        DAQmxErrorRouteNotSupportedByHW
        DAQmxErrorResourcesInUseForExportSignalPolarity
        DAQmxErrorResourcesInUseForInversionInTask
        DAQmxErrorResourcesInUseForInversion
        DAQmxErrorExportSignalPolarityNotSupportedByHW
        DAQmxErrorInversionNotSupportedByHW
        DAQmxErrorOverloadedChansExistNotRead
        DAQmxErrorInputFIFOOverflow2
        DAQmxErrorCJCChanNotSpecd
        DAQmxErrorCtrExportSignalNotPossible
        DAQmxErrorRefTrigWhenContinuous
        DAQmxErrorIncompatibleSensorOutputAndDeviceInputRanges
        DAQmxErrorCustomScaleNameUsed
        DAQmxErrorPropertyValNotSupportedByHW
        DAQmxErrorPropertyValNotValidTermName
        DAQmxErrorResourcesInUseForProperty
        DAQmxErrorCJCChanAlreadyUsed
        DAQmxErrorForwardPolynomialCoefNotSpecd
        DAQmxErrorTableScaleNumPreScaledAndScaledValsNotEqual
        DAQmxErrorTableScalePreScaledValsNotSpecd
        DAQmxErrorTableScaleScaledValsNotSpecd
        DAQmxErrorIntermediateBufferSizeNotMultipleOfIncr
        DAQmxErrorEventPulseWidthOutOfRange
        DAQmxErrorEventDelayOutOfRange
        DAQmxErrorSampPerChanNotMultipleOfIncr
        DAQmxErrorCannotCalculateNumSampsTaskNotStarted
        DAQmxErrorScriptNotInMem
        DAQmxErrorOnboardMemTooSmall
        DAQmxErrorReadAllAvailableDataWithoutBuffer
        DAQmxErrorPulseActiveAtStart
        DAQmxErrorCalTempNotSupported
        DAQmxErrorDelayFromSampClkTooLong
        DAQmxErrorDelayFromSampClkTooShort
        DAQmxErrorAIConvRateTooHigh
        DAQmxErrorDelayFromStartTrigTooLong
        DAQmxErrorDelayFromStartTrigTooShort
        DAQmxErrorSampRateTooHigh
        DAQmxErrorSampRateTooLow
        DAQmxErrorPFI0UsedForAnalogAndDigitalSrc
        DAQmxErrorPrimingCfgFIFO
        DAQmxErrorCannotOpenTopologyCfgFile
        DAQmxErrorInvalidDTInsideWfmDataType
        DAQmxErrorRouteSrcAndDestSame
        DAQmxErrorReversePolynomialCoefNotSpecd
        DAQmxErrorDevAbsentOrUnavailable
        DAQmxErrorNoAdvTrigForMultiDevScan
        DAQmxErrorInterruptsInsufficientDataXferMech
        DAQmxErrorInvalidAttentuationBasedOnMinMax
        DAQmxErrorCabledModuleCannotRouteSSH
        DAQmxErrorCabledModuleCannotRouteConvClk
        DAQmxErrorInvalidExcitValForScaling
        DAQmxErrorNoDevMemForScript
        DAQmxErrorScriptDataUnderflow
        DAQmxErrorNoDevMemForWaveform
        DAQmxErrorStreamDCMBecameUnlocked
        DAQmxErrorStreamDCMLock
        DAQmxErrorWaveformNotInMem
        DAQmxErrorWaveformWriteOutOfBounds
        DAQmxErrorWaveformPreviouslyAllocated
        DAQmxErrorSampClkTbMasterTbDivNotAppropriateForSampTbSrc
        DAQmxErrorSampTbRateSampTbSrcMismatch
        DAQmxErrorMasterTbRateMasterTbSrcMismatch
        DAQmxErrorSampsPerChanTooBig
        DAQmxErrorFinitePulseTrainNotPossible
        DAQmxErrorExtMasterTimebaseRateNotSpecified
        DAQmxErrorExtSampClkSrcNotSpecified
        DAQmxErrorInputSignalSlowerThanMeasTime
        DAQmxErrorCannotUpdatePulseGenProperty
        DAQmxErrorInvalidTimingType
        DAQmxErrorPropertyUnavailWhenUsingOnboardMemory
        DAQmxErrorCannotWriteAfterStartWithOnboardMemory
        DAQmxErrorNotEnoughSampsWrittenForInitialXferRqstCondition
        DAQmxErrorNoMoreSpace
        DAQmxErrorSamplesCanNotYetBeWritten
        DAQmxErrorGenStoppedToPreventIntermediateBufferRegenOfOldSamples
        DAQmxErrorGenStoppedToPreventRegenOfOldSamples
        DAQmxErrorSamplesNoLongerWriteable
        DAQmxErrorSamplesWillNeverBeGenerated
        DAQmxErrorNegativeWriteSampleNumber
        DAQmxErrorNoAcqStarted
        DAQmxErrorSamplesNotYetAvailable
        DAQmxErrorAcqStoppedToPreventIntermediateBufferOverflow
        DAQmxErrorNoRefTrigConfigured
        DAQmxErrorCannotReadRelativeToRefTrigUntilDone
        DAQmxErrorSamplesNoLongerAvailable
        DAQmxErrorSamplesWillNeverBeAvailable
        DAQmxErrorNegativeReadSampleNumber
        DAQmxErrorExternalSampClkAndRefClkThruSameTerm
        DAQmxErrorExtSampClkRateTooLowForClkIn
        DAQmxErrorExtSampClkRateTooHighForBackplane
        DAQmxErrorSampClkRateAndDivCombo
        DAQmxErrorSampClkRateTooLowForDivDown
        DAQmxErrorProductOfAOMinAndGainTooSmall
        DAQmxErrorInterpolationRateNotPossible
        DAQmxErrorOffsetTooLarge
        DAQmxErrorOffsetTooSmall
        DAQmxErrorProductOfAOMaxAndGainTooLarge
        DAQmxErrorMinAndMaxNotSymmetric
        DAQmxErrorInvalidAnalogTrigSrc
        DAQmxErrorTooManyChansForAnalogRefTrig
        DAQmxErrorTooManyChansForAnalogPauseTrig
        DAQmxErrorTrigWhenOnDemandSampTiming
        DAQmxErrorInconsistentAnalogTrigSettings
        DAQmxErrorMemMapDataXferModeSampTimingCombo
        DAQmxErrorInvalidJumperedAttr
        DAQmxErrorInvalidGainBasedOnMinMax
        DAQmxErrorInconsistentExcit
        DAQmxErrorTopologyNotSupportedByCfgTermBlock
        DAQmxErrorBuiltInTempSensorNotSupported
        DAQmxErrorInvalidTerm
        DAQmxErrorCannotTristateTerm
        DAQmxErrorCannotTristateBusyTerm
        DAQmxErrorNoDMAChansAvailable
        DAQmxErrorInvalidWaveformLengthWithinLoopInScript
        DAQmxErrorInvalidSubsetLengthWithinLoopInScript
        DAQmxErrorMarkerPosInvalidForLoopInScript
        DAQmxErrorIntegerExpectedInScript
        DAQmxErrorPLLBecameUnlocked
        DAQmxErrorPLLLock
        DAQmxErrorDDCClkOutDCMBecameUnlocked
        DAQmxErrorDDCClkOutDCMLock
        DAQmxErrorClkDoublerDCMBecameUnlocked
        DAQmxErrorClkDoublerDCMLock
        DAQmxErrorSampClkDCMBecameUnlocked
        DAQmxErrorSampClkDCMLock
        DAQmxErrorSampClkTimebaseDCMBecameUnlocked
        DAQmxErrorSampClkTimebaseDCMLock
        DAQmxErrorAttrCannotBeReset
        DAQmxErrorExplanationNotFound
        DAQmxErrorWriteBufferTooSmall
        DAQmxErrorSpecifiedAttrNotValid
        DAQmxErrorAttrCannotBeRead
        DAQmxErrorAttrCannotBeSet
        DAQmxErrorNULLPtrForC_Api
        DAQmxErrorReadBufferTooSmall
        DAQmxErrorBufferTooSmallForString
        DAQmxErrorNoAvailTrigLinesOnDevice
        DAQmxErrorTrigBusLineNotAvail
        DAQmxErrorCouldNotReserveRequestedTrigLine
        DAQmxErrorTrigLineNotFound
        DAQmxErrorSCXI1126ThreshHystCombination
        DAQmxErrorAcqStoppedToPreventInputBufferOverwrite
        DAQmxErrorTimeoutExceeded
        DAQmxErrorInvalidDeviceID
        DAQmxErrorInvalidAOChanOrder
        DAQmxErrorSampleTimingTypeAndDataXferMode
        DAQmxErrorBufferWithOnDemandSampTiming
        DAQmxErrorBufferAndDataXferMode
        DAQmxErrorMemMapAndBuffer
        DAQmxErrorNoAnalogTrigHW
        DAQmxErrorTooManyPretrigPlusMinPostTrigSamps
        DAQmxErrorInconsistentUnitsSpecified
        DAQmxErrorMultipleRelaysForSingleRelayOp
        DAQmxErrorMultipleDevIDsPerChassisSpecifiedInList
        DAQmxErrorDuplicateDevIDInList
        DAQmxErrorInvalidRangeStatementCharInList
        DAQmxErrorInvalidDeviceIDInList
        DAQmxErrorTriggerPolarityConflict
        DAQmxErrorCannotScanWithCurrentTopology
        DAQmxErrorUnexpectedIdentifierInFullySpecifiedPathInList
        DAQmxErrorSwitchCannotDriveMultipleTrigLines
        DAQmxErrorInvalidRelayName
        DAQmxErrorSwitchScanlistTooBig
        DAQmxErrorSwitchChanInUse
        DAQmxErrorSwitchNotResetBeforeScan
        DAQmxErrorInvalidTopology
        DAQmxErrorAttrNotSupported
        DAQmxErrorUnexpectedEndOfActionsInList
        DAQmxErrorPowerBudgetExceeded
        DAQmxErrorHWUnexpectedlyPoweredOffAndOn
        DAQmxErrorSwitchOperationNotSupported
        DAQmxErrorOnlyContinuousScanSupported
        DAQmxErrorSwitchDifferentTopologyWhenScanning
        DAQmxErrorDisconnectPathNotSameAsExistingPath
        DAQmxErrorConnectionNotPermittedOnChanReservedForRouting
        DAQmxErrorCannotConnectSrcChans
        DAQmxErrorCannotConnectChannelToItself
        DAQmxErrorChannelNotReservedForRouting
        DAQmxErrorCannotConnectChansDirectly
        DAQmxErrorChansAlreadyConnected
        DAQmxErrorChanDuplicatedInPath
        DAQmxErrorNoPathToDisconnect
        DAQmxErrorInvalidSwitchChan
        DAQmxErrorNoPathAvailableBetween2SwitchChans
        DAQmxErrorExplicitConnectionExists
        DAQmxErrorSwitchDifferentSettlingTimeWhenScanning
        DAQmxErrorOperationOnlyPermittedWhileScanning
        DAQmxErrorOperationNotPermittedWhileScanning
        DAQmxErrorHardwareNotResponding
        DAQmxErrorInvalidSampAndMasterTimebaseRateCombo
        DAQmxErrorNonZeroBufferSizeInProgIOXfer
        DAQmxErrorVirtualChanNameUsed
        DAQmxErrorPhysicalChanDoesNotExist
        DAQmxErrorMemMapOnlyForProgIOXfer
        DAQmxErrorTooManyChans
        DAQmxErrorCannotHaveCJTempWithOtherChans
        DAQmxErrorOutputBufferUnderwrite
        DAQmxErrorSensorInvalidCompletionResistance
        DAQmxErrorVoltageExcitIncompatibleWith2WireCfg
        DAQmxErrorIntExcitSrcNotAvailable
        DAQmxErrorCannotCreateChannelAfterTaskVerified
        DAQmxErrorLinesReservedForSCXIControl
        DAQmxErrorCouldNotReserveLinesForSCXIControl
        DAQmxErrorCalibrationFailed
        DAQmxErrorReferenceFrequencyInvalid
        DAQmxErrorReferenceResistanceInvalid
        DAQmxErrorReferenceCurrentInvalid
        DAQmxErrorReferenceVoltageInvalid
        DAQmxErrorEEPROMDataInvalid
        DAQmxErrorCabledModuleNotCapableOfRoutingAI
        DAQmxErrorChannelNotAvailableInParallelMode
        DAQmxErrorExternalTimebaseRateNotKnownForDelay
        DAQmxErrorFREQOUTCannotProduceDesiredFrequency
        DAQmxErrorMultipleCounterInputTask
        DAQmxErrorCounterStartPauseTriggerConflict
        DAQmxErrorCounterInputPauseTriggerAndSampleClockInvalid
        DAQmxErrorCounterOutputPauseTriggerInvalid
        DAQmxErrorCounterTimebaseRateNotSpecified
        DAQmxErrorCounterTimebaseRateNotFound
        DAQmxErrorCounterOverflow
        DAQmxErrorCounterNoTimebaseEdgesBetweenGates
        DAQmxErrorCounterMaxMinRangeFreq
        DAQmxErrorCounterMaxMinRangeTime
        DAQmxErrorSuitableTimebaseNotFoundTimeCombo
        DAQmxErrorSuitableTimebaseNotFoundFrequencyCombo
        DAQmxErrorInternalTimebaseSourceDivisorCombo
        DAQmxErrorInternalTimebaseSourceRateCombo
        DAQmxErrorInternalTimebaseRateDivisorSourceCombo
        DAQmxErrorExternalTimebaseRateNotknownForRate
        DAQmxErrorAnalogTrigChanNotFirstInScanList
        DAQmxErrorNoDivisorForExternalSignal
        DAQmxErrorAttributeInconsistentAcrossRepeatedPhysicalChannels
        DAQmxErrorCannotHandshakeWithPort0
        DAQmxErrorControlLineConflictOnPortC
        DAQmxErrorLines4To7ConfiguredForOutput
        DAQmxErrorLines4To7ConfiguredForInput
        DAQmxErrorLines0To3ConfiguredForOutput
        DAQmxErrorLines0To3ConfiguredForInput
        DAQmxErrorPortConfiguredForOutput
        DAQmxErrorPortConfiguredForInput
        DAQmxErrorPortConfiguredForStaticDigitalOps
        DAQmxErrorPortReservedForHandshaking
        DAQmxErrorPortDoesNotSupportHandshakingDataIO
        DAQmxErrorCannotTristate8255OutputLines
        DAQmxErrorTemperatureOutOfRangeForCalibration
        DAQmxErrorCalibrationHandleInvalid
        DAQmxErrorPasswordRequired
        DAQmxErrorIncorrectPassword
        DAQmxErrorPasswordTooLong
        DAQmxErrorCalibrationSessionAlreadyOpen
        DAQmxErrorSCXIModuleIncorrect
        DAQmxErrorAttributeInconsistentAcrossChannelsOnDevice
        DAQmxErrorSCXI1122ResistanceChanNotSupportedForCfg
        DAQmxErrorBracketPairingMismatchInList
        DAQmxErrorInconsistentNumSamplesToWrite
        DAQmxErrorIncorrectDigitalPattern
        DAQmxErrorIncorrectNumChannelsToWrite
        DAQmxErrorIncorrectReadFunction
        DAQmxErrorPhysicalChannelNotSpecified
        DAQmxErrorMoreThanOneTerminal
        DAQmxErrorMoreThanOneActiveChannelSpecified
        DAQmxErrorInvalidNumberSamplesToRead
        DAQmxErrorAnalogWaveformExpected
        DAQmxErrorDigitalWaveformExpected
        DAQmxErrorActiveChannelNotSpecified
        DAQmxErrorFunctionNotSupportedForDeviceTasks
        DAQmxErrorFunctionNotInLibrary
        DAQmxErrorLibraryNotPresent
        DAQmxErrorDuplicateTask
        DAQmxErrorInvalidTask
        DAQmxErrorInvalidChannel
        DAQmxErrorInvalidSyntaxForPhysicalChannelRange
        DAQmxErrorMinNotLessThanMax
        DAQmxErrorSampleRateNumChansConvertPeriodCombo
        DAQmxErrorAODuringCounter1DMAConflict
        DAQmxErrorAIDuringCounter0DMAConflict
        DAQmxErrorInvalidAttributeValue
        DAQmxErrorSuppliedCurrentDataOutsideSpecifiedRange
        DAQmxErrorSuppliedVoltageDataOutsideSpecifiedRange
        DAQmxErrorCannotStoreCalConst
        DAQmxErrorSCXIModuleNotFound
        DAQmxErrorDuplicatePhysicalChansNotSupported
        DAQmxErrorTooManyPhysicalChansInList
        DAQmxErrorInvalidAdvanceEventTriggerType
        DAQmxErrorDeviceIsNotAValidSwitch
        DAQmxErrorDeviceDoesNotSupportScanning
        DAQmxErrorScanListCannotBeTimed
        DAQmxErrorConnectOperatorInvalidAtPointInList
        DAQmxErrorUnexpectedSwitchActionInList
        DAQmxErrorUnexpectedSeparatorInList
        DAQmxErrorExpectedTerminatorInList
        DAQmxErrorExpectedConnectOperatorInList
        DAQmxErrorExpectedSeparatorInList
        DAQmxErrorFullySpecifiedPathInListContainsRange
        DAQmxErrorConnectionSeparatorAtEndOfList
        DAQmxErrorIdentifierInListTooLong
        DAQmxErrorDuplicateDeviceIDInListWhenSettling
        DAQmxErrorChannelNameNotSpecifiedInList
        DAQmxErrorDeviceIDNotSpecifiedInList
        DAQmxErrorSemicolonDoesNotFollowRangeInList
        DAQmxErrorSwitchActionInListSpansMultipleDevices
        DAQmxErrorRangeWithoutAConnectActionInList
        DAQmxErrorInvalidIdentifierFollowingSeparatorInList
        DAQmxErrorInvalidChannelNameInList
        DAQmxErrorInvalidNumberInRepeatStatementInList
        DAQmxErrorInvalidTriggerLineInList
        DAQmxErrorInvalidIdentifierInListFollowingDeviceID
        DAQmxErrorInvalidIdentifierInListAtEndOfSwitchAction
        DAQmxErrorDeviceRemoved
        DAQmxErrorRoutingPathNotAvailable
        DAQmxErrorRoutingHardwareBusy
        DAQmxErrorRequestedSignalInversionForRoutingNotPossible
        DAQmxErrorInvalidRoutingDestinationTerminalName
        DAQmxErrorInvalidRoutingSourceTerminalName
        DAQmxErrorRoutingNotSupportedForDevice
        DAQmxErrorWaitIsLastInstructionOfLoopInScript
        DAQmxErrorClearIsLastInstructionOfLoopInScript
        DAQmxErrorInvalidLoopIterationsInScript
        DAQmxErrorRepeatLoopNestingTooDeepInScript
        DAQmxErrorMarkerPositionOutsideSubsetInScript
        DAQmxErrorSubsetStartOffsetNotAlignedInScript
        DAQmxErrorInvalidSubsetLengthInScript
        DAQmxErrorMarkerPositionNotAlignedInScript
        DAQmxErrorSubsetOutsideWaveformInScript
        DAQmxErrorMarkerOutsideWaveformInScript
        DAQmxErrorWaveformInScriptNotInMem
        DAQmxErrorKeywordExpectedInScript
        DAQmxErrorBufferNameExpectedInScript
        DAQmxErrorProcedureNameExpectedInScript
        DAQmxErrorScriptHasInvalidIdentifier
        DAQmxErrorScriptHasInvalidCharacter
        DAQmxErrorResourceAlreadyReserved
        DAQmxErrorSelfTestFailed
        DAQmxErrorADCOverrun
        DAQmxErrorDACUnderflow
        DAQmxErrorInputFIFOUnderflow
        DAQmxErrorOutputFIFOUnderflow
        DAQmxErrorSCXISerialCommunication
        DAQmxErrorDigitalTerminalSpecifiedMoreThanOnce
        DAQmxErrorDigitalOutputNotSupported
        DAQmxErrorInconsistentChannelDirections
        DAQmxErrorInputFIFOOverflow
        DAQmxErrorTimeStampOverwritten
        DAQmxErrorStopTriggerHasNotOccurred
        DAQmxErrorRecordNotAvailable
        DAQmxErrorRecordOverwritten
        DAQmxErrorDataNotAvailable
        DAQmxErrorDataOverwrittenInDeviceMemory
        DAQmxErrorDuplicatedChannel
        DAQmxWarningTimestampCounterRolledOver
        DAQmxWarningInputTerminationOverloaded
        DAQmxWarningADCOverloaded
        DAQmxWarningPLLUnlocked
        DAQmxWarningCounter0DMADuringAIConflict
        DAQmxWarningCounter1DMADuringAOConflict
        DAQmxWarningStoppedBeforeDone
        DAQmxWarningRateViolatesSettlingTime
        DAQmxWarningRateViolatesMaxADCRate
        DAQmxWarningUserDefInfoStringTooLong
        DAQmxWarningTooManyInterruptsPerSecond
        DAQmxWarningPotentialGlitchDuringWrite
        DAQmxWarningDevNotSelfCalibratedWithDAQmx
        DAQmxWarningAISampRateTooLow
        DAQmxWarningAIConvRateTooLow
        DAQmxWarningReadOffsetCoercion
        DAQmxWarningPretrigCoercion
        DAQmxWarningSampValCoercedToMax
        DAQmxWarningSampValCoercedToMin
        DAQmxWarningPropertyVersionNew
        DAQmxWarningUserDefinedInfoTooLong
        DAQmxWarningCAPIStringTruncatedToFitBuffer
        DAQmxWarningSampClkRateTooLow
        DAQmxWarningPossiblyInvalidCTRSampsInFiniteDMAAcq
        DAQmxWarningRISAcqCompletedSomeBinsNotFilled
        DAQmxWarningPXIDevTempExceedsMaxOpTemp
        DAQmxWarningOutputGainTooLowForRFFreq
        DAQmxWarningOutputGainTooHighForRFFreq
        DAQmxWarningMultipleWritesBetweenSampClks
        DAQmxWarningDeviceMayShutDownDueToHighTemp
        DAQmxWarningReadNotCompleteBeforeSampClk
        DAQmxWarningWriteNotCompleteBeforeSampClk
