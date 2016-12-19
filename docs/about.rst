HMMER project
=============

The HMMER project is a collaborative project between the HMMER algorithm
developers, led by `Sean Eddy <eddylab.org>`_ at
`HHMI/Harvard University <https://www.hhmi.org>`_
and the HMMER web service team, lead by
`Rob Finn <https://www.ebi.ac.uk/about/people/rob-finn>`_
at `EMBL-EBI <https://www.ebi.ac.uk>`_.

While the HMMER algorithm developers focus on improving the speed and
sensitivity of searches, the HMMER web service team takes these algorithms
and deploys them in a production environment to enable optimal performance,
given a finite set of resources. The service team also works on ensuring
that the underlying HMM and sequences databases are regularly updated and
that search results are presented in intuitive visualisations. The web
interface is freely accessible, allowing users to perform rapid sequence
analyses using the HMMER software suite. The servers allow HMMER to be
used to address a wide variety of questions involving sequence function,
conservation and evolution.

A paper describing the web server has been published in
`Nucleic Acids Research <https://nar.oxfordjournals.org/content/43/W1/W30>`_.
In addition to the human interactive website, we have developed
an API that allows simple machine access to the same infrastructure. This
should allow relatively large scale analysis to be performed in a
timely fashion.
