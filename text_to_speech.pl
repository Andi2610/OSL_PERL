use strict;


&SAPItalk("Hello, and welcome to heaven",0);
&SAPItalk("The following voices are installed.",1);

my %voicelist = &SAPIgetVoices;
my $a = '';
print "\n";
foreach $a (sort keys %voicelist)
{
	print "$voicelist{$a} = $a\n";
}

&SAPItalk("Who would you like to speak next?",0);

my $voice = &ask;;


&SAPItalk("What would you like me to say?",$voice);

my $text = &ask();

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
