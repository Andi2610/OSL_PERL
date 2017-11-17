#!c:/perl/bin/perl.exe -w
use strict;
use warnings;


&SAPItalk("Hello, and welcome to Heaven",0);

my %voicelist = &SAPIgetVoices;
my $a = '';
print "\n";

system("python","imgreader.py")== 0 or die "Python script returned error $?";
foreach $a (sort keys %voicelist)
{
	print "$voicelist{$a} = $a\n";
}

&SAPItalk("Who would you like to speak next?",0);

my $voice = &ask;;

my $text = "";
my $filename = 'Output.txt';
open (my $fh,'<:encoding(UTF-8)',$filename) or die "Could not read file";
 while (my $row = <$fh>) {
 	 $text = $text .''."$row\n";
 }


 

&SAPItalk($text,$voice);

&SAPItalk("Thank you, and have a nice day.",0);

exit(0);
sub ask
{
	my $answer = <STDIN>;
	chomp($answer);
	return $answer;
}
sub SAPIgetVoices
{
	use Win32::OLE;

	my $tts = Win32::OLE->new("Sapi.SpVoice") or die "Sapi.SpVoice failed";
	my %VOICES;
	for(my $VoiceCnt=0;$VoiceCnt < $tts->GetVoices->Count();$VoiceCnt++)
	{
		my $desc = $tts->GetVoices->Item($VoiceCnt)->GetDescription;

		$VOICES{"$desc"} = $VoiceCnt;
	}
	return %VOICES;
}

sub SAPItalk
{
	use Win32::OLE;

	my ($text,$voice) = @_;

	my $tts = Win32::OLE->new("Sapi.SpVoice") or die "Sapi.SpVoice failed";
	$tts->{Voice} = $tts->GetVoices->Item($voice);

	print "[ $text ]\n";
	$tts->Speak("$text", 1);

	$tts->WaitUntilDone(-1);
}