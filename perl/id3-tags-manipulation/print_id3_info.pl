#!/usr/bin/perl
#
# print_id3_info.pl
# Uses the autoinfo() function to pick up selected fields and print the tag info
# Saves the artwork in a file
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

# get the tag info
$mp3->get_tags();

# configure the order in which the information is picked up.
# we only want ID3v2 and if the info is not available then ID3v1
$mp3->config("autoinfo", "ID3v2", "ID3v1");

# get tag information
my ($title, $track, $artist, $album, $performer, $comment, $year, $genre) = $mp3->autoinfo();

# extract artwork
if (!exists($mp3->{ID3v2})) {
	warn("No ID3v2: $filename\n. Can not get artwork.\n");
} else {
  my $apic_frame = $mp3->{ID3v2}->get_frame("APIC");
  my $img_data = $$apic_frame{'_Data'};
  my $mime_type = $$apic_frame{'MIME type'};
  
  # if there is artwork in the file, write the artwork to a seperate file
  if (!$img_data) {
  	warn "No artwork data found: $filename\n";
  	next;
  } else {
  	# mime_type will have value like image/jpeg, 
  	# spliting the same to get an extension for the artwork file
  	my ($mime1, $mime2) = split(/\//, $mime_type);
  	
  	#create a filename to save the artwork to
  	my $artwork_name = $filename . ".$mime2";
  	open ARTWORK_FILE, ">$artwork_name" or die "Error creating the artwork file";
  	binmode(ARTWORK_FILE);
  	print ARTWORK_FILE $img_data;
  	close ARTWORK_FILE;
  }
}

$mp3->close();

say "Title: $title";
say "Artist: $artist";
say "Album: $album";
say "Performer: $performer";
say "Track: $track";
say "Year: $year";
say "Genre: $genre";
say "Comment: $comment";
