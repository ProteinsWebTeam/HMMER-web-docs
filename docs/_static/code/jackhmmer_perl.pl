#!/usr/bin/env perl
use strict;
use warnings;
use LWP::UserAgent;
use JSON;

#Get a new Web user agent.
my $ua = LWP::UserAgent->new;
$ua->timeout(60);
$ua->env_proxy;
#Set a new JSON end encoder/decoder
my $json = JSON->new->allow_nonref;

#-------------------------------------------------------------------------------
#Set up the job

#URL to query
my $rootUrl = "http://www.ebi.ac.uk/Tools/hmmer";
my $url = $rootUrl."/search/jackhmmer";

my $seq = ">2abl_A mol:protein length:163  ABL TYROSINE KINASE
MGPSENDPNLFVALYDFVASGDNTLSITKGEKLRVLGYNHNGEWCEAQTKNGQGWVPSNYITPVNSLEKHS
WYHGPVSRNAAEYLLSSGINGSFLVRESESSPGQRSISLRYEGRVYHYRINTASDGKLYVSSESRFNTLAE
LVHHHSTVADGLITTLHYPAP";

my %content = (
  'algo'     => 'jackhmmer',
  'seq'      => $seq,
  'seqdb'    => 'pdb',
  iterations => 5,
);

#-------------------------------------------------------------------------------
#Now POST the request and generate the search job.
my $response = $ua->post(
  $url,
  'content-type' => 'application/json',
  Content        => $json->encode( \%content )
);

if($response->status_line ne "201 Created"){
  die "Failed to create job, got:".$response->status_line;
}

my $job = $json->decode( $response->content );
print "Generated job UUID:".$job->{job_id}."\n";

#Follow the redicrection to the resouce create for the job.
my $job_location = $response->header("location");
#Now poll the server until the job has finished
$response = $ua->get( $job_location, 'Accept' => 'application/json' );

my $max_retry = 50;
my $count     = 1;

while ( $response->status_line eq '200 OK' ) {
  my $status = $json->decode( $response->content );

  print "Checking status ($count)......";
  if ( $status->{status} eq 'DONE' ) {
    print "Job done.\n";
    last;
  }
  elsif ( $status->{status} eq 'ERROR' ) {
    print "Job failed, exiting!\n";
    exit(1);
  }
  elsif ( $status->{status} eq 'RUN' or $status->{status} eq 'PEND' ) {
    my ($lastIteration) = $status->{result}->[-1]->{uuid} =~ /\.(\d+)/;
    print "Currently on iteration $lastIteration [$status->{status}].\n";
  }

  if ( $count > $max_retry ) {
    print "Jobs should have finished.....exiting\n";;
    exit(1);
  }
  #Job still running, so give it a chance to complete.
  sleep(5);
  #Check again on the job status...
  $response = $ua->get( $job_location, 'Accept' => 'application/json' );
  $count++;
}

#Job should have finished, but we may have converged, so get the last job.
my $results = $json->decode( $response->content );
my $lastIteration = pop( @{ $results->{result} } );
#Now fetch the results of the last iteration
my $searchResult = $ua->get( $rootUrl."/results/" . $lastIteration->{uuid} . "/score", 'Accept' => 'application/json' );
unless( $searchResult->status_line eq "200 OK"){
  die "Failed to get search results\n";
}

#Decode the content of the full set of results
$results = $json->decode( $searchResult->content );
print "Matched ".$results->{'results'}->{'stats'}->{'nincluded'}." sequences ($lastIteration->{uuid})!\n";
#Now do something more interesting with the results......
