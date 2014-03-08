.. _installation:

Installation
------------

The CyDAQmx Base library has been build and run for Python 2.7 and Cython 0.18,
running with NI-DAQmx Base 3.7 in a Linux environment.  However any reasonable
Python (probably >=2.6) and Cython version should work.  If you use the library
and have any problems with it, please report them on the `issue tracker`_.

Dependencies
============

The primary dependency is the NI-DAQmx Base library.  The driver should be
downloadable from the `National Instruments drivers page`_.  The LabView
Runtime Library engine must be installed such that ldconfig can find it (the
default installation procedure is sufficient).

The Python dependencies for this library are Cython and NumPy.  These should
both be installable using you favorite Python package installation methods
(pip, easy_install, etc).

Note that the NI-DAQmx Base library only supplies 32-bit libraries.  This means
only 32-bit versions of Python will be able to install this library.  These
likely means you will need a different version than what is supplied with your
distribution.

Source
======

Tagged releases are available from the GitHub `releases`_ page.  It is
reccomended that you download the most recent tagged tarball.  Exctracting the
tarball will give you a folder called ``cydaqmxbase``.

From the ``cydaqmxbase`` folder, you can build the library by running::

    $ python setup.py build_ext --inplace

This will run the compilation of the Cython modules.  If the compilation runs
without error, the library is likely good, but you may at this point wish to
run the small test suite::

    $ py.test

Note that this requires you to have installed ``pytest``.

You can now install the library, simply by running::

    $ python setup.py install

Now, check the module documentation for information on using the CyDAQmx Base
library.

.. _issue tracker: https://github.com/flacjacket/cydaqmxbase/issues
.. _National Instruments drivers page: http://www.ni.com/downloads/ni-drivers/
.. _releases: https://github.com/flacjacket/cydaqmxbase/releases
