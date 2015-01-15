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
use Path::Iterator::Rule;
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
<link rel="stylesheet" href="http://yui.yahooapis.com/pure/0.5.0/pure-min.css">
</head>
<body>
<h1>My MP3 Collection</h1>
<table class="pure-table pure-table-horizontal">
    <thead>
        <tr>
            <th>Album Artwork</th>
			<th>Album</th>
            <th>Track</th>
            <th>Title</th>
            <th>Artist</th>
			<th>Year</th>
			<th>Genre</th>
			<th>Comment</th>
        </tr>
    </thead>

    <tbody>
		<!-- TMPL_LOOP NAME=SONGS -->
		<tr>
			<td><a src="<TMPL_VAR NAME=FILEPATH>"><img src="<TMPL_VAR NAME=IMG>" height="150" width="150"/></a></td>
			<td><!-- TMPL_VAR NAME=ALBUM --></td>
			<td><!-- TMPL_VAR NAME=TRACK --></td>
			<td><!-- TMPL_VAR NAME=TITLE --></td>
			<td><!-- TMPL_VAR NAME=ARTIST --></td>
			<td><!-- TMPL_VAR NAME=YEAR --></td>
			<td><!-- TMPL_VAR NAME=GENRE --></td>
			<td><!-- TMPL_VAR NAME=COMMENT --></td>
		</tr>
		<!-- /TMPL_LOOP -->
    </tbody>
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
	push @{$song_data}, &getTagInfo($file);
}
$tmpl->param(SONGS => $song_data);
say $tmpl->output();

sub getTagInfo {
	
	if (@_ != 1) {
	  die "&getTagInfo must get only one argument - the file name from where the mp3 tags are to be extracted\n";
	}
	
	# initializing variables
	my ($title, $track, $artist, $album, $comment, $year, $genre) = "";
	my ($imgData, $mimeType) = "";
	my $image = "";
	
	my $fileName = shift @_;
	
	# spliting the directory, filename and suffix(extension) from fileName
	my ($name, $path, $suffix) = fileparse($fileName);
	
	
	
	# create new MP3-Tag object
	my $mp3 = MP3::Tag->new($fileName);
	
	# get the tag info
	$mp3->get_tags();
	
	# configure the order in which the information is picked up.
	# we only want ID3v2 and if the info is not available then ID3v1
	$mp3->config("autoinfo", "ID3v2", "ID3v1");
	
	# if ID3v2 is not present, then let us check for ID3v1 presence
	if (!exists($mp3->{ID3v2})) {
		warn("\nNo ID3v2: $fileName. Artwork won't be possible.");
		# if ID3v1 is also not present then no tag info will be possible at all.
		if (!exists($mp3->{ID3v1})) {
			warn("No ID3v1: $fileName.");
			warn("No tag information will be possible.")
		}
	} else {
		# extract artwork since ID3v2 is present
		my $apic_frame = $mp3->{ID3v2}->get_frame("APIC");
		$imgData = $$apic_frame{'_Data'};
		$mimeType = $$apic_frame{'MIME type'};
	}
	
	# get tag information
	($title, $track, $artist, $album, $comment, $year, $genre) = $mp3->autoinfo();	

	$image = &artworkToFile($imgData, $mimeType, $name, $album);

	return {
		"title" => $title, 
		"track" => $track, 
		"artist" => $artist, 
		"album" => $album, 
		"comment" => $comment, 
		"year" => $year, 
		"genre" => $genre, 
		"img" => $image,
		"filepath" => $fileName
	};

}

sub artworkToFile {
  if (@_ != 4) {
      die "&artworkToFile must get only four arguments - the image data, the mime type, the mp3 filename and the album name\n";
  }
  
  my ($imgData, $mimeType, $fileName, $album) = @_;
 
  if(! $imgData) {
	  return;
  }
  # mime_type will have value like image/jpeg, 
  # spliting the same to get an extension for the artwork file
  my ($mime1, $mime2) = split(/\//, $mimeType);
  
  # creating the filename based on the mp3 filename and with the correct extension as per mime type
  #$fileName =~ s/.mp3$/.$mime2/;
  
  # remove trailing slash from the artwork location path
  $artworkLocation =~ s/\/$//;
  
  # fixing filename to remove any special characters
  $album =~ s/(\s+|\(|\)|\/)/_/g;
  
  # create a filename to save the artwork to
  my $artworkName = $artworkLocation . "/" . $album . "." . $mime2;
  
  #
  # TODO - Need to check if Album Artwork file already exists at the desired location. If so then don't create
  #
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