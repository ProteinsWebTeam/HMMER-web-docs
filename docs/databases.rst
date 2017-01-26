Target databases
================

The HMMER web service supports querying against a range of
regularly updated sequence and HMM target databases.

------------------
Sequence databases
------------------

* Large, comprehensive sequence collection

  - `UniProtKB <http://www.uniprot.org>`_ - Comprehensive resource for protein sequence and annotation
    data produced by the Universal Protein Resource consortium.

* Annotated sequences and determined 3D structures

  - `Swiss-Prot <http://www.uniprot.org>`_ - Manually reviewed, high quality protein sequence and
    functional annotation - produced by UniProt.

  - `PDB <http://www.pdb.org>`_ - Sequences with an experimentally determined structure.

* Representative Sets

  - `Representative Proteomes <http://www.proteininformationresource.org/rps>`_ - Representative Proteomes (RPs) are determined
    by selecting one proteome from a representative proteome group
    containing similar proteomes calculated based on sequence co-membership
    in UniRef50 clusters. A Representative Proteome is the proteome that can
    best represent all the proteomes in its group in terms of the majority
    of the sequence space and information. RPs at 75%, 55%, 35% and 15%
    co-membership threshold are available as target databases. More
    information on `Representative Proteomes <http://www.plosone.org/article/info%3Adoi%2F10.1371%2Fjournal.pone.0018910>`_ is available. The data set
    also includes model organisms and viral reference proteomes as defined
    by UniProt. The complete proteomes database comes from PIR.

  - `Reference Proteomes <http://www.uniprot.org>`_ - A set of proteomes from UniProt that gives broad
    coverage of the tree of life, and constitutes a representative
    cross-section of the taxonomic diversity to be found within UniProtKB.
    Produced by UniProt, in collaboration with Ensembl and the NCBI
    Reference Sequence collection.

* Other

  - `Ensembl Genomes <http://www.ensemblgenomes.org>`_ - Ensembl Genomes is a
    resource for genomic data for several thousands of invertebrate species.
    All translations resulting from known and novel gene predictions in Ensembl Genomes,
    including hypothetical proteins, are included. For lists of all the species
    in each sub division within Ensembl Genomes please see
    `Bacteria <http://bacteria.ensembl.org/index.html>`_,
    `Fungi <http://fungi.ensembl.org/index.html>`_,
    `Metazoa <http://metazoa.ensembl.org/index.html>`_,
    `Plants <http://plants.ensembl.org/index.html>`_
    and `Protists <http://protists.ensembl.org/index.html>`_.

  - `Ensembl <http://www.ensembl.org>`_ - Searches may be performed across the entire set or one of
    `Human <http://www.ensembl.org/Homo_sapiens>`_,
    `Mouse <http://www.ensembl.org/Mus_musculus>`_, or
    `Zebrafish <http://www.ensembl.org/Danio_rerio>`_

  - `Quest for Orthologs <http://questfororthologs.org>`_

The default database is UniProt reference proteomes.

---------------------
Profile HMM databases
---------------------

* `Pfam <http://pfam.xfam.org>`_ - A large comprehensive collection of protein families.

* `TIGRFAMs <http://www.jcvi.org/cgi-bin/tigrfams/index.cgi>`_
  - Models that are designed for automated sequence annotation
  and that are aimed at matching the full length (or near) of the
  sequence.

* `Gene3D <http://gene3d.biochem.ucl.ac.uk>`_
  - A collection of models that are based on CATH structural
  protein domains.

* `SUPERFAMILY <http://supfam.cs.bris.ac.uk/SUPERFAMILY/>`_
  - A collection of models, which represent structural protein
  domains at the SCOP superfamily level.

* `PIRSF <http://pir.georgetown.edu/pirwww/dbinfo/pirsf.shtml>`_ -
  Models that are designed to provide a comprehensive and
  non-overlapping clustering of UniProtKB.

The default database is Pfam.

-----------------
Search provenance
-----------------

Clicking 'Search Details' at the end of the result page
reveals a box that provides details of the search, including
the query sequence (if applicable) and information
regarding the date/release
of the target databases, which should be recorded for future reference
when trying to recreate the results, discussing with colleagues or
reporting bugs.
