.. Set up the paramters

.. |parameters.popen.min| replace:: 0
.. |parameters.popen.max| replace:: 0.5
.. |parameters.popen.default| replace:: 0.02
.. |parameters.pextend.min| replace:: 0
.. |parameters.pextend.max| replace:: 1
.. |parameters.pextend.default| replace:: 0.4
.. |parameters.mx.default| replace:: BLOSUM62
.. |parameters.seq.minSeqLength| replace:: 6
.. |parameters.seq.maxSeqLength| replace:: 10000
.. |parameters.incE.min| replace:: 0
.. |parameters.incE.max| replace:: 10
.. |parameters.incE.default| replace:: 0.01
.. |parameters.incdomE.min| replace:: 0
.. |parameters.incdomE.max| replace:: 10
.. |parameters.incdomE.default| replace:: 0.03
.. |parameters.incT.min| replace:: 0
.. |parameters.incT.default| replace:: 25.0
.. |parameters.incdomT.min| replace:: 0
.. |parameters.incdomT.default| replace:: 22.0
.. |parameters.E.min| replace:: 0
.. |parameters.E.max| replace:: 10
.. |parameters.E.default| replace:: 1
.. |parameters.domE.min| replace:: 0
.. |parameters.domE.max| replace:: 10
.. |parameters.domE.default| replace:: 1
.. |parameters.T.min| replace:: 0
.. |parameters.T.default| replace:: 7.0
.. |parameters.domT.min| replace:: 0
.. |parameters.domT.default| replace:: 5.0
.. |parameters.file.maxNumLines| replace:: 42000
.. |parameters.file.maxNumSeqs| replace:: 500
.. |parameters.file.size| replace:: 3000000
.. |parameters.file.minNumResidueTypes| replace:: 5

========
Searches
========

-------------------------
Default search parameters
-------------------------

The searches on the website, when used in the simple mode, hide most of
the search parameters and default values are used. Below is a list of
the parameters and values used in the default search for each algorithm:

phmmer
++++++

+--------------------------------------+----------------------------------------------------+
| Sequence database                    | Uniprot reference proteomes                        |
+--------------------------------------+----------------------------------------------------+
| Significance threshold (E-value)     | |parameters.incE.default| for sequence matches;    |
|                                      | |parameters.incdomE.default| for hit matches       |                              
+--------------------------------------+----------------------------------------------------+
| Reporting threshold (E-value)        | |parameters.E.default| for both sequences and hits |
+--------------------------------------+----------------------------------------------------+
| Gap penalties                        | open value: |parameters.popen.default|;            |
|                                      | extend value: |parameters.pextend.default|;        |
|                                      | scoring matrix: |parameters.mx.default|            |
+--------------------------------------+----------------------------------------------------+
| Filter                               | Bias composition filtering on                      |
+--------------------------------------+----------------------------------------------------+
| Pfam search                          | Enabled, with gathering thresholds applied         |
+--------------------------------------+----------------------------------------------------+

hmmscan
+++++++

+--------------------------------------+----------------------------------------------------+
| HMM database                         | Pfam                                               |
+--------------------------------------+----------------------------------------------------+
| Significance threshold               | The Pfam defined thresholds (gathering thresholds) |
|                                      | are used to determine hit significance             |
+--------------------------------------+----------------------------------------------------+
| Filter                               | Bias composition filtering on                      |
+--------------------------------------+----------------------------------------------------+

hmmsearch
+++++++++

+--------------------------------------+----------------------------------------------------+
| Sequence database                    | Uniprot reference proteomes                        |
+--------------------------------------+----------------------------------------------------+
| Significance threshold (E-value)     | |parameters.incE.default| for sequence matches,    |
|                                      | |parameters.incdomE.default| for hit matches       |                            
+--------------------------------------+----------------------------------------------------+
| Reporting threshold (E-value)        | |parameters.E.default| for both sequences and hits |
+--------------------------------------+----------------------------------------------------+
| Filter                               | Bias composition filtering on                      |
+--------------------------------------+----------------------------------------------------+

jackhmmer
+++++++++

+--------------------------------------+----------------------------------------------------+
| Sequence database                    | Uniprot reference proteomes                        |
+--------------------------------------+----------------------------------------------------+
| Significance threshold (E-value)     | |parameters.incE.default| for sequence matches;    |
|                                      | |parameters.incdomE.default| for hit matches       |                              
+--------------------------------------+----------------------------------------------------+
| Reporting threshold (E-value)        | |parameters.E.default| for both sequences and hits |
+--------------------------------------+----------------------------------------------------+
| Gap penalties                        | open value: |parameters.popen.default|;            |
|                                      | extend value: |parameters.pextend.default|;        |
|                                      | scoring matrix: |parameters.mx.default|            |
+--------------------------------------+----------------------------------------------------+
| Filter                               | Bias composition filtering on                      |
+--------------------------------------+----------------------------------------------------+

--------------
Batch Searches
--------------

It is also possible to search multiple protein sequences in 'offline'
batch mode. With both **phmmer** and **hmmscan**, files
containing sequences in FASTA format can be uploaded via the
"Upload a file" link. These sequences will then be searched, in turn,
against the specified databases. There is a limit of 500
sequences per batch request. This is only to prevent overload of the servers: multiple
batch requests are permitted.
Once the job is
submitted, a different results page will be returned, showing a
table with each row in that table representing a sequence in your file.
This table periodically updates, indicating the progress of your batch
job. As results appear in the table, you can view the details. If you
have many sequences, you can also request that an e-mail be sent when
the batch job has completed.
It is also possible to use **hmmsearch** in batch mode, again with a
single multiple alignment or profile HMM.

The **jackhmmer** batch system operates in a slightly different manner.
Under the advance settings you can select the number of iterations to be
performed and the batch mode will automaticaly run through each
iteration (or until convergence), taking the results and using all the
sequences scoring above the significance threholds to generate the input
multiple sequnece alignment for the next round. Only one sequence,
multiple sequence aligment or profile HMM can be submitted at a time.

The batch system also works via the API, except the seq parameter is
substituted for the file parameter; the other parameters remain the
same. Requesting an e-mail notification can be set using the email
parameter.

--------
Glossary
--------

Bit score
  A bit score in HMMER is the log of the ratio of the sequence's
  probability according to the profile (the homology hypothesis) to the
  null model probability (the non-homology hypothesis).

E-value
  An E-value (expectation value) is the number of hits that would be
  expected to have a score equal to or better than this by chance alone. A
  good E-value is much less than 1, for example, an E-value of 0.01 would
  mean that on average about 1 false positive would be expected in every
  100 searches with different query sequences. An E-value around 1 is what
  we expect just by chance. E-values are widely used as all you need to
  decide on the significance of a match is the E-value, but note that they
  vary according to the size of the target database.

Gathering threshold
  Also called the gathering cut-off, the gathering threshold is actually
  comprised of two bit scores, a sequence cut-off and a domain cut-off,
  used to define the significance of a sequence and a hit respectively.
  These are defined in the profile HMM and set both significance and
  reporting thresholds so that no insignificant hits are reported.

Null model
  The "null model" calculates the probability that the target sequence is
  not homologous to the query profile and is a one-state HMM configured to
  generate "random" sequences of the same mean length L as the target
  sequence, with each residue drawn from a background frequency
  distribution (a standard i.i.d. model: residues are treated as
  independent and identically distributed). This background frequency is
  based on the mean residue frequencies in
  `Swiss-Prot 50.8 <http://www.uniprot.org>`_ (October 2006).

Profile HMM
  Profile hidden Markov Models (HMMs) are a way of turning a multiple
  sequence alignment into a position-specific scoring system, which is
  suitable for searching databases for remotely homologous sequences.

STOCKHOLM format
  `STOCKHOLM <https://en.wikipedia.org/wiki/Stockholm_format>`_ format is a multiple sequence alignment format supported by
  HMMER.
