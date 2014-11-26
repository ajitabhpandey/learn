#!/usr/bin/perl
#
# genCatalog.pl
# Generates an HTML catalog of the MP3 files
# https://metacpan.org/pod/MP3::Tag
#
use 5.010;
use warnings;
use strict;
use lib "/Users/ajitabh/perl5/lib/perl5";
use Getopt::Std;
use File::Basename;
use PATH::Iterator::Rule;
use MP3::Tag;
use HTML::Template;

my ($startLocation, $artworkLocation);

my %options=();
getopts("s:d:h", \%options);

if (defined $options{h}) {
	&showUsage;
}
if (defined $options{s}) {
	$startLocation = $options{s};
}
if (defined $options{d}) {
	$artworkLocation = $options{d};
}


# define HTML template
my $template = <<HTML;
<html>
<head>
<title>My MP3 Catalog</title>
<style>
  body {padding: 0 2em;font-family: sans-serif;color: #444;background: #eee;}
  h1 {font-weight: normal; letter-spacing: -1px;color: #34495E;}
  table {margin: 1em 0;min-width: 300px;border: 1;background: #34495E;color: #fff;border: 1px solid black;border-radius: .4em;overflow: hidden;}
  tr {border-top: 1px solid #ddd;border-bottom: 1px solid #ddd;}
  th { text-align: center;}
  td {
    display: block;
    text-align: left;
    &:first-child {
      padding-top: .5em;
    }
    &:last-child {
      padding-bottom: .5em;
    }}
</style>
</head>
<body>
<h1>My MP3 Collection</h1>
<table border="1">
   <tr>
     <th>Album Artwork</th><th>Track</th><th>Title</th><th>Artist</th><th>Album</th><th>Year</th><th>Genre</th><th>Comment</th>
   </tr>
<!-- TMPL_LOOP NAME=SONGS -->
   <tr>
     <td><a src="<TMPL_VAR NAME=FILEPATH>"><img src="<TMPL_VAR NAME=IMG>" height="150" width="150"/></a></td>
     <td><!-- TMPL_VAR NAME=TRACK --></td>
     <td><!-- TMPL_VAR NAME=TITLE --></td>
     <td><!-- TMPL_VAR NAME=ARTIST --></td>
     <td><!-- TMPL_VAR NAME=ALBUM --></td>
     <td><!-- TMPL_VAR NAME=YEAR --></td>
     <td><!-- TMPL_VAR NAME=GENRE --></td>
     <td><!-- TMPL_VAR NAME=COMMENT --></td>
   </tr>
<!-- /TMPL_LOOP -->
</table>
</body>
</html>
HTML

my $tmpl = HTML::Template->new(scalarref => \$template);

# Create a new rule object
my $rule = Path::Iterator::Rule->new;

# Set the rules for iteration
$rule->name("*.mp3");

my $iterator = $rule->iter($startLocation);

my $song_data;
while (my $file = $iterator->()) {
	push @{$song_data}, &getBibInfo($file);
}
$tmpl->param(SONGS => $song_data);
say $tmpl->output();

sub getBibInfo {
	
	if (@_ != 1) {
	  die "&getBinInfo must get only one argument - the file name from where the mp3 tags are to be extracted\n";
	}
	my $fileName = shift @_;
	
	# create new MP3-Tag object
	my $mp3 = MP3::Tag->new($fileName);
	
	# get the tag info
	$mp3->get_tags();
	
	# configure the order in which the information is picked up.
	# we only want ID3v2 and if the info is not available then ID3v1
	$mp3->config("autoinfo", "ID3v2", "ID3v1");
	
	# get tag information
	my ($title, $track, $artist, $album, $comment, $year, $genre) = $mp3->autoinfo();
	my ($imgData, $mimeType);
	
	# extract artwork
	if (!exists($mp3->{ID3v2})) {
		warn("No ID3v2: $fileName\n. Can not get artwork.\n");
	} else {
		my $apic_frame = $mp3->{ID3v2}->get_frame("APIC");
		$imgData = $$apic_frame{'_Data'};
		$mimeType = $$apic_frame{'MIME type'};
	}
	
	# spliting the directory, filename and suffix(extension) from fileName
	my ($name, $path, $suffix) = fileparse($fileName);
	
	return {
		"title" => $title, 
		"track" => $track, 
		"artist" => $artist, 
		"album" => $album, 
		"comment" => $comment, 
		"year" => $year, 
		"genre" => $genre, 
		"img" => &artworkToFile($imgData, $mimeType, $name),
		"filepath" => $name
	};

}

sub artworkToFile {
  if (@_ != 3) {
      die "&artworkToFile must get only three arguments - the image data, the mime type and the mp3 filename\n";
  }
  
  my ($imgData, $mimeType, $fileName) = @_;
 
  # mime_type will have value like image/jpeg, 
  # spliting the same to get an extension for the artwork file
  my ($mime1, $mime2) = split(/\//, $mimeType);
  
  # creating the filename based on the mp3 filename and with the correct extension as per mime type
  $fileName =~ s/.mp3$/.$mime2/;
    
  #create a filename to save the artwork to
  my $artworkName = $artworkLocation . "/" . $fileName;
  open ARTWORK_FILE, ">$artworkName" or die "Error creating the artwork file - $artworkName";
  binmode(ARTWORK_FILE);
  print ARTWORK_FILE $imgData;
  close ARTWORK_FILE;
  
  return $artworkName;
}

sub showUsage {
	say "Usage: genCatalog.pl [-s source_of_mp3] [-d destination_for_artwork]  [-h ]\n";
    exit(1);
}