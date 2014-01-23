"""NI DAQmx Base error classes """

__all__ = ['NIDAQmxBaseErrorBase', 'NIDAQmxBaseError', 'TaskNotStarted']

class NIDAQmxBaseErrorBase(Exception):
    """Base exception class"""
    pass

class NIDAQmxBaseError(NIDAQmxBaseErrorBase):
    def __init__(self, errno=None, msg=None):
        """Wrap an DAQmx Base Error

        Parameters
        ----------

        errno : int
            The NI DAQmx Base error number

        msg : string
            Description of the error
        """
        self.errno = errno
        self.msg = msg

        if msg is None:
            self.strerror = errno
        else:
            self.strerror = msg

    def __str__(self):
        return self.strerror

    def __repr__(self):
        return "NIDAQmxBaseError(%s, '%s')" % (self.errno, self.msg)

class TaskNotStarted(NIDAQmxBaseErrorBase):
    """Raised when trying to perform actions before starting the task"""
    pass
