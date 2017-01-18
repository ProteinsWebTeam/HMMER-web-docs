#!/usr/bin/perl

use strict;
use warnings;
use LWP::UserAgent;
use XML::Simple;

#Get a new Web user agent.
my $ua = LWP::UserAgent->new;
$ua->timeout(20);
$ua->env_proxy;

my $host = "http://www.ebi.ac.uk/Tools/hmmer";
my $search = "/search/phmmer";

#Parameters
my  $seq = qq(>2abl_A mol:protein length:163  ABL TYROSINE KINASE
MGPSENDPNLFVALYDFVASGDNT
LSITKGEKLRVLGYNHNGEWCEAQ
TKNGQGWVPSNYITPVNSLEKHSW
YHGPVSRNAAEYLLSSGINGSFLV
RESESSPGQRSISLRYEGRVYHYR
INTASDGKLYVSSESRFNTLAELV
HHHSTVADGLITTLHYPAP);

my $seqdb = 'pdb';

#Make a hash to encode for the content.
my %content = ( 'seqdb' => $seqdb,
                'content'   => "<![CDATA[$seq]]>" );

#Convert the parameters to XML
my $xml = XMLout(\%content, NoEscape => 1);

#Now post it off
my $response = $ua->post( $host.$search, 'content-type' => 'text/xml', Content => $xml );

#By default, we should get redirected!
if($response->is_redirect){

  #Now make a second requests, a get this time, to get the results.
  $response =
  $ua->get($response->header("location"), 'Accept' => 'text/xml' );

  if($response->is_success){
    print $response->content;
  }else{
    print "Error with redirect GET:".$response->content;
    die $response->status_line;
  }
}else{
  die $response->status_line;
}
