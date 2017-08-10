================================
Some notes on hacking on kitchen
================================

:Author: Toshio Kuratomi
:Maintainer: Ralph Bean
:Date: 2 Dec 2014
:Version: 1.2.x

For coding and kitchen, see the style guide in the documentation.

This file documents meta-information about kitchen such as where to get the
code and how to make a release.

.. contents::

-----------------------------------------
Extra software needed for making releases
-----------------------------------------
Although kitchen has very few requirements for running, there are a few more
that are required for making a release:

* python-2.4+ (tested on python-2.7)
* transifex-client (/usr/bin/tx)
* gettext (/usr/bin/msgfmt)
* python-babel (/usr/bin/pybabel)
* python-sphinx (/usr/bin/sphinx-build)
* python-nose (/usr/bin/nosetests)
* python-coverage (/usr/bin/coverage)

--------------
Get translated
--------------

We use the translation services at transifex.net to manage po files, coordinate
people translating strings, and merge new strings to the files.  The following
instructions briefly tell how to use transifex to update the source languages'
files and pull new translations for release.  Actually doing translations can
be found in the `transifex user's guide`_.

.. `transifex user's guide`:: http://help.transifex.net/user-guide/translating.html

To generate the POT file (located in the po/ subdirectory), use pybabel to
extract the messages.  Run the following from the top level directory::

  pybabel extract -o po/kitchen.pot kitchen2 kitchen3

Then commit this pot file and upload to transifex::

  tx push -s
  git commit -m 'Extract new strings from the source files' po/kitchen.pot
  git push

To pull messages from transifex prior to making a release, do::

  tx pull -a
  git commit -m 'Merge new translations from transifex' po/*.po

If you see a status message from transifex like this::
  Pulling new translations for resource kitchen.kitchenpot (source: po/kitchen.pot)
     -> fr: po/fr.po

it means that transifex has created a brand new po file for you.  You need to
add the new file to source control and commit it like this::

  git add po/fr.po
  git commit -m 'New French translation' po/fr.po


TODO: Add information about announcing string freeze.  Using transifex's add
release function to coordinate with translators.  Mailing a translators list,
etc.

--------
Releases
--------

.. note:: If a release is not time critical, make an effort to get the
    software translated first.  See :id:`Get translated` for details.

Testing
=======

Even though python is a compiled language, there's several ways to test that
the software is correct.

Test that docs build
--------------------

Documentation is written in ReStructuredText format and built via the
:mod:`sphinx` documentation system for python.  There is a variety of
hand-written and formatted documentation in the :file:`docs` directory.  Those
documents also pull some documentation out of the docstrings in the code.

Any of those places may have formatting that is not valid in the sphinx
system.  Building the documentation into html will see if there's any spots
that need to be fixed::

  python setup.py build_sphinx --fresh-env

The command will attempt to turn the documentation into html.  Any errors or
warnings in the output mean that there's some piece of documentation that
sphinx doesn't know how to deal with.  That should be fixed before publishing
the release.


Test that message catalogs compile
----------------------------------

One of the pieces of creating a new release is downloading new message
catalogs from transifex.  Once in a great while, a translator will upload a
translation there that causes problems (for instance, adding or omitting
format strings from a translated string.)  Luckily the commands to create the
message catalogs will detect things like this so just compiling the catalogs
will determine if any translations need to be adjusted::

    ./releaseutils.py

This will iterate through all the message catalogs that transifex downloaded
to the :file:`po` directory and compile them into the :file:`locale`
directory.

.. warning:: If :file:/usr/bin/msgfmt is not installed, this command will still
    compile the message catalogs but it will use babel.  Babel, unfortunately,
    doesn't check for all the errors in message catalogs that msgfmt does so
    it may say that the messages are fine when they really aren't.  Make sure
    you have msgfmt available by installing gettext.

Unittest
--------

Kitchen has a large set of unittests.  All of them should pass before release.
You can run the unittests with the following command::

    ./runtests.sh

This will run all the unittests under the tests directory and also generate
some statistics about which lines of code were not accessed when kitchen ran.

.. warning:: Although 100% test coverage is a worthy goal, it doesn't mean
    that the code is bug free.  This is especially true of code, like
    kitchen's, that deals with encoding issues.  The same piece of code in
    kitchen will do different things depending on whether unicode or byte str
    (and the characters that are in the byte str) is passed as a parameter and
    what encoding is specified in certain environment variables.  You can take
    a look at :file:`test_i18n.py` and :file:`test_converters.py` to see tests
    that attempt to cover enough input values to detect problems.

Since kitchen is currently supported on python2 and python3, it is desirable to
run tests against as many python versions as possible.  We currently have a
jenkins instance in the Fedora Infrastructure private cloud with a job set up
for kitchen at http://jenkins.cloud.fedoraproject.org/job/kitchen/

It is not currently running tests against python-2.{3,4,5,6}.  If you are
interested in getting those builds running automatically, please speak up in
the #fedora-apps channel on freenode.

Creating the release
====================


Then commit this pot file and upload to transifex:

1. Make sure that any feature branches you want have been merged.

2. Make a fresh branch for your release::

    git flow release start $VERSION

3. Extract strings for translation and push them to transifex::

    pybabel extract -o po/kitchen.pot kitchen2 kitchen3
    tx push -s
    git commit -m 'Extract new strings from the source files' po/kitchen.pot
    git push

4. Wait for translations.  In the meantime...
5. Update the version in ``kitchen/__init__.py`` and ``NEWS.rst``.
6. When they're all ready, pull in new translations and verify they are valid::

    tx pull -a
    # If msgfmt is installed, this will check that the catalogs are valid
    ./releaseutils.py
    git commit -m 'Merge new translations from transifex.net'
    git push

7. Create a pull-request so someone else from #fedora-apps can review::

    hub pull-request -b master

8. Once someone has given it a +1, then make a source tarball::

    python setup.py sdist

9. Upload the docs to pypi::

    mkdir -p build/sphinx/html
    sphinx-build kitchen2/docs/ build/sphinx/html
    python setup.py upload_docs

10. Upload the tarball to pypi::

     python setup.py sdist upload --sign

11. Upload the tarball to fedorahosted::

     scp dist/kitchen*tar.gz* fedorahosted.org:/srv/web/releases/k/i/kitchen/

12. Tag and bag it::

     git flow release finish -m $VERSION -u $YOUR_GPG_KEY_ID $VERSION
     git push origin develop:develop
     git push origin master:master
     git push origin --tags
     # Your pull-request should automatically close.  Double-check this, though.
