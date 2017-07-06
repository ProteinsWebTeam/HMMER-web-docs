---
API
---

Introduction
++++++++++++

Using curl
^^^^^^^^^^

The following section demonstrates a simple way of
sending and retrieving XML using
the simple Unix command line tool curl.
The following example POSTs the request to the server (our server configuration requires you to also unset the default value in the header for Expect, -H 'Expect:'): 

.. code:: bash

  curl -L -H 'Expect:' -H 'Accept:text/xml' -F seqdb=pdb -F algo=phmmer -F seq='<test.seq' https://www.ebi.ac.uk/Tools/hmmer/search/phmmer

.. literalinclude:: _static/code/phmmer_curl_post_response.xml
   :language: xml

In this example, the sequence to be searched is in the file test.seq. The value of
the parameter "seq" needs to be quoted so that its value is taken correctly from the file.
The other parameters can also be added directly to the URL, as a regular CGI-style parameter, if you prefer.

Using a script
^^^^^^^^^^^^^^

Most programming languages have the ability to send HTTP requests and receive HTTP responses. A Perl script to submit a search and receive the responses as XML might be as trivial as this: 

.. literalinclude:: _static/code/phmmer_perl_post.pl
   :language: perl
   :linenos:

Retrieving results
^^^^^^^^^^^^^^^^^^

Although XML is just plain text and therefore human-readable, it's intended to be
parsed into a data structure. Extending the Perl script above, we can add the ability
to parse the XML using an external Perl module, XML::LibXML: 

.. literalinclude:: _static/code/phmmer_perl_post_read.pl
   :language: perl
   :linenos:

This script now prints out the name, description and E-value of all significant sequence hits
for the given query sequence in tab delimited format::

  2abl_A	mol:protein length:163  ABL TYROSINE KINASE	1.1e-110
  2fo0_A	mol:protein length:495  Proto-oncogene tyrosine-protein kinase ABL1 (	8.4e-109
  1opk_A	mol:protein length:495  Proto-oncogene tyrosine-protein kinase ABL1	8.4e-109
  1opl_A	mol:protein length:537  proto-oncogene tyrosine-protein kinase	9.7e-109
  1ab2_A	mol:protein length:109  C-ABL TYROSINE KINASE SH2 DOMAIN	3.3e-62
  3k2m_A	mol:protein length:112  Proto-oncogene tyrosine-protein kinase ABL1	3.1e-61
  2ecd_A	mol:protein length:119  Tyrosine-protein kinase ABL2	6.5e-58
  1abo_A	mol:protein length:62  ABL TYROSINE KINASE	1.1e-38
  3eg1_A	mol:protein length:63  Proto-oncogene tyrosine-protein kinase ABL1	1.6e-38
  3eg0_A	mol:protein length:63  Proto-oncogene tyrosine-protein kinase ABL1	1.7e-38
  3eg3_A	mol:protein length:63  Proto-oncogene tyrosine-protein kinase ABL1	3.3e-38
  1ju5_C	mol:protein length:61  Abl	8.4e-38
  1bbz_A	mol:protein length:58  ABL TYROSINE KINASE	7.0e-36
  2o88_A	mol:protein length:58  Proto-oncogene tyrosine-protein kinase ABL1	9.1e-35
  1awo_A	mol:protein length:62  ABL TYROSINE KINASE	1.7e-34

Available services
++++++++++++++++++

phmmer searches
^^^^^^^^^^^^^^^

The main two input parameters to a phmmer search are a protein sequence
and the target database, defined using the seq and seqdb parameters
respectively. Other parameters for controlling the search are defined
in the search section. If any of these parameters are omitted, then the
default values for that parameter will be set.

Searches should be POST-ed to the following url::

  https://www.ebi.ac.uk/Tools/hmmer/search/phmmer

Example::

  curl -L -H 'Expect:' -H 'Accept:text/xml' -F seqdb=pdb -F seq='<test.seq' https://www.ebi.ac.uk/Tools/hmmer/search/phmmer

When using the website, we also perform a Pfam search by default. However,
when using the API you will only be returned the phmmer results.
To get Pfam search results, use the hmmscan interface.

hmmscan searches
^^^^^^^^^^^^^^^^

Hmmscan also has two main parameters - a sequence and a profile HMM
database - defined using the seq and hmmdb parameters respectively. We
currently offer four profile HMM databases: Pfam, TIGRFAMs, Gene3D,
Superfamily, and PIRSF. When searching against the former two, the
cut-offs can be defined by the user (other parameters for controlling
the search are defined in the search section). With the latter two HMM
databases, all cut-off parameters will be ignored and the HMM database
default parameters will be used. This is because Gene3D and Superfamily
both use their own post-processing mechanisms to defined their domains,
in addition to the hmmscan results.

Searches should be POST-ed to the following url::

  https://www.ebi.ac.uk/Tools/hmmer/search/hmmscan

Example::

  curl -L -H 'Expect:' -H 'Accept:text/xml' -F hmmdb=pfam -F seq='<test.seq' https://www.ebi.ac.uk/Tools/hmmer/search/hmmscan

hmmsearch searches
^^^^^^^^^^^^^^^^^^

The input to hmmsearch on the web is either a multiple sequence alignment
or a hidden Markov model in HMMER3 format. We do not support HMMER2 format
as these HMMs are not forward compatible with HMMER3. When uploading a
multiple sequence alignment, an HMM is built on the server using hmmbuild
with the default parameters.

Searches should be POST-ed to the following url::

  https://www.ebi.ac.uk/Tools/hmmer/search/hmmsearch

Example::

  curl -L -H 'Expect:' -H 'Accept:text/xml' -F seqdb=pdb -F seq='<test.ali' https://www.ebi.ac.uk/Tools/hmmer/search/hmmsearch

jackhmmer searches
^^^^^^^^^^^^^^^^^^

Jackhmmer is an iterative search algorithm that can be initiated with
a sequence, multiple sequence alignment or profile HMM. The number of
iterations to run can be supplied as an additional parameter and will
perform a succession of searches until the job has completed. Fetching
the results is a little more complicated, as the search may finish before
the number of iterations if it converges.

Searches should be POST-ed to the following url::

  https://www.ebi.ac.uk/Tools/hmmer/search/jackhmmer

Example::

  curl -L -H 'Expect:' -H 'Accept:text/xml' -F seqdb=pdb -F iterations=5 -F seq='<test1.fa' https://www.ebi.ac.uk/Tools/hmmer/search/jackhmmer


Annotation searches
^^^^^^^^^^^^^^^^^^^

In addition to the standard HMMER searches an uploaded sequence can be annotated to show
signal peptide & transmembrane regions, disordered regions and coiled-coil regions.

Annotation requests should be POST-ed to the following urls.

Disorder::

  https://www.ebi.ac.uk/Tools/hmmer/annotation/disorder

Example::

  curl -L -H 'Expect:' -H 'Accept:text/xml' -F  seq='<test.fa' https://www.ebi.ac.uk/Tools/hmmer/annotation/disorder

Coiled-coil::

  https://www.ebi.ac.uk/Tools/hmmer/annotation/coils

Example::

  curl -L -H 'Expect:' -H 'Accept:text/xml' -F  seq='<test.fa' https://www.ebi.ac.uk/Tools/hmmer/annotation/coils

Transmembrane & Signal Peptides::

  https://www.ebi.ac.uk/Tools/hmmer/annotation/phobius

Example::

  curl -L -H 'Expect:' -H 'Accept:text/xml' -F  seq='<test.fa' https://www.ebi.ac.uk/Tools/hmmer/annotation/phobius

Annotation results can be fetched with a GET request using the UUID supplied in the POST response::

  https://www.ebi.ac.uk/Tools/hmmer/annotation/<annotation-type>/UUID

Example::

  curl -H 'Expect:' -H 'Accept:text/xml' https://www.ebi.ac.uk/Tools/hmmer/annotation/phobius/4162F712-1DD2-11B2-B17E-C09EFE1DC403

Results
^^^^^^^

Search results can be retrieved using the job identifier that is returned in your initial search response.
The job identifier is a UUID (format such as 4162F712-1DD2-11B2-B17E-C09EFE1DC403).
Thus, to retrieve your job, you can use the following URL in a GET request::

  https://www.ebi.ac.uk/Tools/hmmer/results/$your_uuid?output=html

Example::

  https://www.ebi.ac.uk/Tools/hmmer/results/4162F712-1DD2-11B2-B17E-C09EFE1DC403?output=html

This is one of the few services where the returned format can be modified using a parameter.

+-------------------+-------------------------------+-------------------------------+-------------------------------+
|**Parameter**      |range                          |ali                            |output                         |
+-------------------+-------------------------------+-------------------------------+-------------------------------+
|**Description**    |The range of the results to    |Return alignments              |Modify the format that the     |
|                   |retrieve                       |                               |results are returned in        |
+-------------------+-------------------------------+-------------------------------+-------------------------------+
|**Accepted values**|Integer,Integer                |true | 1                       |xml | json | text | yaml       |
+-------------------+-------------------------------+-------------------------------+-------------------------------+
|**Example**        |range=1,100                    |ali=1                          |html                           |
+-------------------+-------------------------------+-------------------------------+-------------------------------+
|**Default/Without**|All results                    |No alignments will be returned |output=text                    |
|**Parameter**      |                               |                               |                               |
+-------------------+-------------------------------+-------------------------------+-------------------------------+
|**Notes**          |The results are ordered by     |Sometimes you are not so       |The format of the results can  |
|                   |E-value and as there can be    |interested in the alignment of |be modified with by setting    |
|                   |thousands of matches to your   |the match to the query         |"output=$format". The same can |
|                   |query, it can be useful to     |sequence. By default no        |be achieved by setting the     |
|                   |retrieve a subset of results.  |alignments are returned, to    |"Accept" field in the HTTP     |
|                   |The range is two, unsigned,    |keep results compact.          |header. If both the HTTP header|
|                   |comma separated integers. The  |                               |and the parameter are set, we  |
|                   |first integer is expected to be|                               |currently assume that the      |
|                   |less than the second integer.  |                               |parameter is the desired       |
|                   |To retrieve one row, just fetch|                               |format.                        |
|                   |using a range where the two    |                               |                               |
|                   |integers are the same value. If|                               |                               |
|                   |your first integer is in range,|                               |                               |
|                   |and your second is out of      |                               |                               |
|                   |range, the second integer will |                               |                               |
|                   |be modified to include all     |                               |                               |
|                   |results. i.e. If your results  |                               |                               |
|                   |set is only 300 in size, and a |                               |                               |
|                   |range of 1,1000 is requested,  |                               |                               |
|                   |then you will get 300 results. |                               |                               |
|                   |If your starting integer is    |                               |                               |
|                   |"out" of range, then no results|                               |                               |
|                   |will be returned.              |                               |                               |
+-------------------+-------------------------------+-------------------------------+-------------------------------+

Deleting results
^^^^^^^^^^^^^^^^

The results will normally only remain on the server for a maximum of one week; however they may be deleted
by sending a DELETE request.

Taxonomy and domain views
^^^^^^^^^^^^^^^^^^^^^^^^^

The API may also be used to retrive the data behind the taxonomy and domain architecture tabs on the results
page. For taxonomy the URL has the form::

  https://www.ebi.ac.uk/Tools/hmmer/results/$your_uuid/taxonomy

Example::

  curl -s -H "Content-type: application/json" 'https://www.ebi.ac.uk/Tools/hmmer/results/8D5B74A0-6158-11E7-B311-1331132D729D/taxonomy'

The fields returned are described in :ref:`Appendix F - JSON format`

For domain architecture, two endpoints are provided. The first returns an overview of all architectures::

  https://www.ebi.ac.uk/Tools/hmmer/results/$your_uuid/domain

Example::

  curl -s -H "Content-type: application/json" 'https://www.ebi.ac.uk/Tools/hmmer/results/8D5B74A0-6158-11E7-B311-1331132D729D/domain'

The second queries an individual architecture identifier::

  https://www.ebi.ac.uk/Tools/hmmer/results/$your_uuid/domain/$arch_id

Example::

  curl -s -H "Content-type: application/json" 'https://www.ebi.ac.uk/Tools/hmmer/results/D33FBDA4-6230-11E7-BC34-E492DBC3747A/domain/36055491190690'

Examples
++++++++

phmmer
^^^^^^

The following piece of python is a little more complex than those
discussed previously. In this case, we submit a search to the server,
but stop the HTTP handler from automatically following the redirection
to the results page. Instead, a custom handler is define that grabs the
redirection URL and modifies it by the addition of parameters such that
it fetches just the first 10 matches in JSON format, rather than grabbing
the whole response. This can be useful when the results are large and
you want to paginate the response, or if you are only interested in the
most significant sequence matches.

.. literalinclude:: _static/code/phmmer_python.py
   :language: perl
   :linenos:

hmmscan
^^^^^^^

The following is a very basic Java source file that, once compiled
and and executed performs an hmmscan search. The response is returned
in JSON format. With this two stage POST and GET, you can POST the
request in one format and get a response back in another by setting
the Accept type. To get this example to work, you should save the
code in a file called RESTClient.java. Then run the command "javac
RESTClient.java". Assuming that this is successful and a file called
RESTClient.class is produced, you can execute the class by running the
command "java RESTClient"

.. literalinclude:: _static/code/java_hmmscan.java
   :language: java
   :linenos:

jackhmmer
^^^^^^^^^

A jackhmmer is a multipart search. The following Perl code performs a
series of requests to the server. The first POST request generates the
jobs, the while loop then performs GET requests to get the job status,
until the status of the job is done. The last request GETs the results
of the last iteration, which are returned in JSON format.

.. literalinclude:: _static/code/jackhmmer_perl.pl
   :language: perl
   :linenos:

Batch searches
^^^^^^^^^^^^^^

So far, the submission of batch searches via REST has not really been
mentioned. This is because we do not anticipate this being so useful
as you can programmatically send sequence after sequence. However, a
batch upload of sequences is possible for phmmer and hmmscan. The main
difference is that instead of using the seq parameter, we use the file
parameter. There is also a subtle difference in the way that the curl
command is formulated. Rather than using a redirect (<), a the symbol is
used to force the content part of the request to be what is contained
within the file, rather than being attached to the parameter::

  curl -L -H 'Expect:' -H 'Accept:text/xml' -F seqdb=pdb -F file='@batch.fasta' https://www.ebi.ac.uk/Tools/hmmer/search/phmmer


It is also possible to include an email address for notification of when
the batch search has been processed. Again, not particularly useful for
an API, but it may be useful for keeping track of a pipeline. To specify
an email via the command line, simply use the parameter email and set
this to a valid email address. All of the other phmmer or hmmscan search
parameters apply to the batch search.

Fetching results
^^^^^^^^^^^^^^^^

Using curl to fetch results is very easy::

  curl -L -H 'Expect:' -H 'Accept:text/xml' https://www.ebi.ac.uk/Tools/hmmer/results/CF5BCDA4-0C7E-11E0-AF4F-B1E277D6C7BA?output=text&ali=1&range=1,2

In this case we want to fetch the first two hits, with their alignments as a textual output format.
