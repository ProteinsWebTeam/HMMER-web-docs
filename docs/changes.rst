Changelog
=========

**Version 2.7, September 2016**

- Changes

  - UniProt release 2016_08
  - Gene3D version 14

**Version 2.6, August 2016**

- Changes

  - Ensembl Genomes 32

- Bug fixes

  - Fixes in search and download pages

**Version 2.5, July 2016**

- Changes

  - small UI improvements

**Version 2.4, June 2016**

- New features

  - Integration of complete Ensembl Plants, and of Ensembl Protists
    as supported databases for searches.

  - Update to Pfam 30.0

- Changes

  - More UI changes to the search page

**Version 2.3, May 2016**

- New features

  - Integration of Ensembl Bacteria, Ensembl Fungi, Ensembl Metazoa,
    and Ensembl Plants as supported databases for searches.

- Changes

  - Small changes in the UI (especially in the search page)
  - Improved performance and better caching

**Version 2.2, March 2016**

- New features

  - Integration of Ensembl Genomes as a supported database for searches.

- Bug fixes

  - Fixed error on selection between iterations of Jackhmmer searches

**Version 2.1, January 2016**

- New features

  - RP levels that were previously removed have been reinstated by popular demand.
  - Revisions to the help documentation.
  - PDB search results now link to both PDBe and RCSB.

**Version 2.0, August 2015**

- New features

  - Move from Janelia to EBI.
  - Now supporting Ensembl Genomes Plants as a new target database.
  - RP levels removed.

**Version 1.4, May 2013**

- New features

  - We have enabled the searching of **multiple** hmm databases via hmmscan.  This
    allows the results of Gene3D, Superfamily, Pfam and TIGRGAMs to be compared in a single page.
  - The **HMM length** and the coverage of the HMM is now indicated in the tool tip associated with the
    domain graphic, located in the 'sequence features' section.  The HMM length has also been added to the hmmscan
    results table.
  - The website is now using HMMER **version 3.1**, with the software due to be released shortly.  We have added the option of downloading
    HMMs in both 3.0 and 3.1 formats.
  - **Alignment downloads** have been improved, particularly for large alignments, which were often so big that the server would timeout.
  - We have also work on several speed optimisations in the website to improve interactivity.

- Bug Fixes

  - Based on user feedback, we have updated the validation of E-value cut-offs to allow **scientific notation** with the
    exponent as E or e.
  - Fixed issue with **long taxon names** which are now being truncated
    to ensure that tree, in taxonomy results visualisation, remains aligned.
