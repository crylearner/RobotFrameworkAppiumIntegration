====
NEWS
====

:Author: Toshio Kuratomi
:Maintainer: Ralph Bean
:Date: 13 Nov 2015
:Version: 1.2.x

-----
1.2.4
-----

* Further compat fixes for python-3.5

-----
1.2.3
-----

* Compatibility with python-3.5

-----
1.2.2
-----

* Compatibility with python-3.4
* Compatibility with pep470

-----
1.2.1
-----

* Fix release-related problems with the 1.2.0 tarball.
  - Include locale data for the test suite.
  - Include NEWS.rst and README.rst.
  - Include runtests.sh.
  - Adjust trove classifiers to indicate python3 support.

-----
1.2.0
-----

* kitchen gained support for python3.  The tarball release now includes a
  ``kitchen2/`` and a ``kitchen3/`` directory containing copies of the source
  code modified to work against each of the two major python versions.  When
  installing with ``pip`` or ``setup.py``, the appropriate version should be
  selected and installed.
* The canonical upstream repository location moved to git and github.  See
  https://github.com/fedora-infra/kitchen
* Added kitchen.text.misc.isbasestring(), kitchen.text.misc.isbytestring(),
  and kitchen.text.misc.isunicodestring().  These are mainly useful for code
  being ported to python3 as python3 lacks a basestring type and has two types
  for byte strings.  Code that has to run on both python2 and python3 or
  wants to provide similar byte vs unicode semantics may find these functions
  to be a good abstraction.
* Add a python2_api parameter to various i18n functions: NullTranslations
  constructor, NewGNUTranslations constructor, and get_translation_object.
  When set to True (the default), the python2 api for gettext objects is used.
  When set to False, the python3 api is used.  This option is intended to aid
  in porting from python2 to python3.
* Exception messages are no longer translated.  The idea is that exceptions
  should be easily searched for via a web search.
* Fix a bug in unicode_to_xml() where xmlcharrefs created when a unicode
  string is turned into a byte string with an encoding that doesn't have 
  all of the needed characters had their ampersands ("&") escaped.
* Fix a bug in NewGNUTranslations.lngettext() if a fallback gettext object is
  used and the message is not in any catalog.
* Speedups to process_control_chars() that are directly reflected in
  unicode_to_xml() and byte_string_to_xml()
* Remove C1 Control Codes in to_xml() as well as C0 Control Codes

-----
1.1.1
-----

* Fix a bug with easy_gettext_setup() and get_translation_object() when using
  the default value of localedirs.

-----
1.1.0
-----

* Add yum.i18n.exception2msg section to the porting docs
* Deprecate BYTE_EXCEPTION_CONVERTERS as simplification of code lets
  us use EXCEPTION_CONVERTERS for both exception_to_unicode and
  exception_to_bytes.
* kitchen.i18n.get_translation_object
  - Add more parameters to :func:`~kitchen.i18n.get_translation_object` so it
    can more easily be used as a replacement for :func:`gettext.translation`.
  - Change the way we use localedirs.  We cycle through them until we find a
    suitable locale file rather than simply cycling through until we find a
    directory that exists.
  - When multiple message catalogs are found in localedirs (and via environment
    variables), set up the extra ones as fallbacks if the message isn't found
    in the first catalog.
* Change the return values from gettext and lgettext family of functions.
  Instead of simply guaranteeing a byte str will be returned we now guarantee
  the byte str will be valid in a certain encoding (the str may still be
  mangled but it will be valid).
* Updated subprocess and base64 modules from latest python-2.7 branch.
* Fix i18n Translation objects to set input_charset and output_charset on any
  fallback objects.
* Fix kitchen.i18n Translation objects' output_encoding() method on python-2.3.
  It was accessing a different self object than we wanted it to.  Defining it
  in a different way makes it work on python-2.3.

-----
1.0.0
-----

* Add a pointer to ordereddict and iterutils in the docs
* Change a few pieces of code to not internally mix bytes and unicode

-----
0.2.4
-----

* Have easy_gettext_setup return lgettext functions instead of gettext
  functions when use_unicode=False
* Correct docstring for kitchen.text.converters.exception_to_bytes() -- we're
  transforming into a byte str, not into unicode.
* Correct some examples in the unicode frustrations documentation
* Correct some cross-references in the documentation

-----
0.2.3
-----

* Expose MAXFD, list2cmdline(), and mswindows in kitchen.pycompat27.subprocess.
  These are undocumented, and not in upstream's __all__ but google (and bug
  reports against kitchen) show that some people are using them.  Note that
  upstream is leaning towards these being private so they may be deprecated in
  the python3 subprocess.

-----
0.2.2
-----

* Add kitchen.text.converters.exception_to_bytes() and
  kitchen.text.converters.exception_to_unicode() that take an exception object
  and convert it into a text representation.
* Add a documentation section on how API can be simplified if you can limit your encodings

If all goes well, we'll be making a 1.0 release shortly which is basically this release.

-------
0.2.2a1
-------

* Fix exception messages that contain unicode characters
* Speed up to_unicode for the common cases of utf-8 and latin-1.
* kitchen.i18n.NewGNUTranslations object that always returns unicode for
  ugettext and ungettext, always returns str for the other gettext functions,
  and doesn't throw UnicodeError.
* Change i18n functions to return either DummyTranslations or
  NewGNUTranslations so all strings returned are known to be unicode or str.
* kitchen.pycompat24.base64 now synced from upstream python so it implements
  all of the python-2.4 API
* unittest NewGNUTranslations
* unittest that easy_gettext_setup returns the correct objects
* Document kitchen.text.display
* Proofread all of the documentation.  Cross reference to the stdlib.
* Write a porting guide for people porting from python-fedora and yum APIs.

-------
0.2.1a1
-------

* Fix failing unittest on python-2.7
* Add iterutils module
* Update table of combining utf8 characters from python-2.7
* Speed up kitchen.text.misc.str_eq().
* docs:
  - api-i18n
  - api-exceptions
  - api-collections
  - api-iterutils
  - Add two tutorial sections for unicode
* unittests
  - kitchen.text.converters.getwriter()
  - kitchen.iterutils
  - tests for more input variations to str_eq

-----
0.2a2
-----
* Add unittests for kitchen.text.display, update kitchen.text.utf8 and
  kitchen.text.misc test coverage
* Bug fixes for python-2.3
* Some doc updates.  More to come.
* New function kitchen.text.converters.getwriter()

-----
0.2a1
-----
* Relicense to LGPLv2+
* All API versions for subpackages moved to 1.0 to comply with new guidelines
  on hacking subpackages.
* Documentation on hacking kitchen and addons
* Kitchen.text API changed (new API version 1.0)
  * Move utils.* to misc.*
  * Deprecate kitchen.text.utf8.utf8_valid in favor of
    kitchen.text.misc.byte_string_valid_encoding
    - byte_string_valid_encoding is significantly faster and a bit more generic
  * Port utf8 functions to use unicode
  * Put the unicode versions of the utf8 functions into kitchen.text.display

-----
0.1a3
-----
* Add a defaultdict implementation for pycompat25
* Add documentation
* Add a StrictDict class that never has str and unicode keys collide.

-----
0.1a2
-----
* Fixes for python-2.3
* versioning subpackage with version_tuple_to_string() function that creates
  PEP-386 compatible version strings.
* Changed pycompat24.builtinset -- now you need to call the add_builtin_set()
  function to add set and frozenset to the __builtin__ namespace.
* pycompat24.base64modern module that implements the modern interface to
  encode and decode base64.  Note that it does't implement b32 or b16 at the
  moment.
* pycompat27 with the 2.7 version of subprocess.
* The 2.7 version of subprocess is also available at
  kitchen.pycompat24.subprocess since subprocess first appeared in python2.4

-----
0.1a1
-----
* Initial releae of kitchen.core
