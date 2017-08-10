===================
Kitchen.core Module
===================

:Author: Toshio Kuratomi
:Maintainer: Ralph Bean
:Date: 13 Nov 2015
:Version: 1.2.x

The Kitchen module provides a python API for all sorts of little useful
snippets of code that everybody ends up writing for their projects but never
seem big enough to build an independent release.  Use kitchen and stop cutting
and pasting that code over and over.

.. contents::

-------
License
-------

Since version 0.2a1, this python module has been distributed under the terms of
the GNU Lesser General Public License Version 2 or later.

.. note:: Some parts of this module are licensed under terms less restrictive
    than the LGPL.  If you separate these files from the work as a whole you
    are allowed to use them under the less restrictive licenses.  The following
    is a list of the files that are known:

    :subprocess.py: licensed under the Python 2 license by the PSF
        http://www.python.org/download/releases/2.4/license/
    :test_subprocess.py: Python Software Foundation License Version 2
        http://www.python.org/download/releases/2.7/license/
    :kitchen/pycompat25/defaultdict.py: Python Software Foundation License Version 2
        http://www.python.org/download/releases/2.6.2/license

------------
Requirements
------------

kitchen.core requires

:python: 2.4 or later

Since version 1.2.0, this package has distributed both python2 and python3
compatible versions of the source.

Soft Requirements
=================

If found, these libraries will be used to make the implementation of something
better in some way.  If they are not present, the API that they enable will
still exist but may function in a different manner.

:chardet_: Used in kitchen.text.xml.guess_encoding__to_xml() to help guess encoding of
    byte strings being converted.  If not present, unknown encodings will be
    converted as if they were latin1.

.. _chardet:: http://chardet.feedparser.org/

---------------------------
Other Recommended Libraries
---------------------------

These libraries implement commonly used functionality that everyone seems to
invent.  Rather than reinvent their wheel, I simply list the things that they
do well for now.  Perhaps if people can't find them normally, I'll add them as
requirements in setup.py or link them into kitchen's namespace.  For now, I
just mention them here:

:bunch_: Bunch is a dictionary that you can use attribute lookup as well as
    bracket notation to access.  Setting it apart from most homebrewed
    implementations is the bunchify() function which will descend nested
    structures of lists nad dicts, transforming the dicts to Bunch's.

.. _bunch:: http://pypi.python.org/pypi/bunch/

---------------------
Building, and testing
---------------------

Testing
=======

You can run the unittests with this command::

    ./runtests.sh
