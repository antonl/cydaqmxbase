CyDAQmxBase
===========

CyDAQmxBase is a Cython wrapper around the National Instruments
NI-DAQmx Base driver.

Dependencies
------------

CyDAQmxBase requires the NI-DAQmx Base driver to be installed.  The libraries
for the LabVIEW Runtime Engine (liblvrtdark) must be installed in a location
that can be found by ldconfig.  The location of NIDAQmxBase.h in assumed by
default to be under the default prefix, ``/usr/local/natinst/``, this can be
configured by the distutils option ``--include-dirs=dir``

Building and running has been tested on Python 2.7 with Cython 0.18, but the
code should be fairly portable.  Because the NI-DAQmx Base driver only includes
32-bit libraries, this package must be installed with a 32-bit Python version.
NumPy is also required to run CyDAQmxBase.

Installation
------------

You can build CyDAQmxBase by running::

	$ python setup.py build_ext --inplace

To install CyDAQmxBase, simply run::

	$ python setup.py install

Usage
-----

The CyDAQmxBase library can be imported as `nidaqmxbase`.  See the
documentation for how to use the library.
