#!/usr/bin/perl
#
# id3v1_write.pl
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
  say "Filename: $filename";
  say ".................... I AM OVER-WRITING THE ID3V1 TAGS WITH MY OWN CUSTOM VALUES .............";
  say "Press return to proceed....";
  getc(STDIN);
} else {
  # create a new ID3v1 tag and write it to file
 $mp3->new_tag("ID3v1");
}

my $id3v1 = $mp3->{ID3v1};
# Setting the new tags with custom values
$id3v1->title("My Track");
$id3v1->artist("Me aka Rock Star");
$id3v1->album("My First Album");
$id3v1->year("2004");
# write all info at once
#$id3v1->all("song title","artist","album","1900","comment",10,"Ska");

# writing the tags
$id3v1->write_tag();

# clean up
$mp3->close();
