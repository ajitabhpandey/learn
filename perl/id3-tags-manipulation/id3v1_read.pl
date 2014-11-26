#!/usr/bin/perl
#
# id3v1_read.pl
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

# check to see if an ID3v1 tag exists
# if it does, print track information
if (exists $mp3->{ID3v1}) {
  #$mp3->{ID3v1}->remove_tag();exit;

  say "Filename: $filename";
  say "Artist: " . $mp3->{ID3v1}->artist;
  say "Title: " . $mp3->{ID3v1}->title;
  say "Album: " . $mp3->{ID3v1}->album;
  say "Year: ". $mp3->{ID3v1}->year;
  say "Genre: " . $mp3->{ID3v1}->genre;
} else {
  say "$filename: ID3v1 tag not found";
}

# clean up
$mp3->close();
