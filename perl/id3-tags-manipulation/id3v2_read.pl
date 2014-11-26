#!/usr/bin/perl
#
# id3v2_read.pl
# https://metacpan.org/pod/MP3::Tag
#
use 5.010;
use warnings;
use strict;
use lib "/Users/ajitabh/perl5/lib/perl5";
use MP3::Tag;

# set filename of MP3 track
my $filename = "/Users/ajitabh/Dinah.mp3";

# create new MP3-Tag object
my $mp3 = MP3::Tag->new($filename);

# get tag information
$mp3->get_tags();

# check to see if an ID3v2 tag exists
# if it does, print track information
if (exists $mp3->{ID3v2}) {
  # get a list of frames as a hash reference
  my $frames = $mp3->{ID3v2}->get_frame_ids();

  # iterate over the hash, process each frame
  foreach my $frame (keys %$frames) {
    # for each frame get a key-value pair of content-description
    my ($value, $desc) = $mp3->{ID3v2}->get_frame($frame);
    if (defined($desc) and length $desc) {
      say "$frame $desc: "; 
    } else {
      say "$frame :";
    }
    # sometimes the value is itself a hash reference containing more values
    # deal with that here
    if (ref $value eq "HASH") {
      while (my ($k, $v) = each (%$value)) {
        say "\n     - $k: $v";
      }
    } else {
      say "$value";
    }
    getc(STDIN);
  }
} else {
  say "$filename: ID3v2 tag not found";
}

# clean up
$mp3->close();
