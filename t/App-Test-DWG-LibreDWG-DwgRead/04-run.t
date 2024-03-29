use strict;
use warnings;

use App::Test::DWG::LibreDWG::DwgRead;
use English;
use File::Object;
use File::Spec::Functions qw(abs2rel);
use Test::More 'tests' => 2;
use Test::NoWarnings;
use Test::Output;

# Test.
@ARGV = (
	'-h',
);
my $script = abs2rel(File::Object->new->file('04-run.t')->s);
# XXX Hack for missing abs2rel on Windows.
if ($OSNAME eq 'MSWin32') {
	$script =~ s/\\/\//msg;
}
my $right_ret = <<"END";
Usage: $script [-d test_dir] [-f] [-h] [-i] [-m match_string] [-v level] [--version] directory
	-d test_dir	Test directory (default is directory in system tmp).
	-f		Print file.
	-h		Print help.
	-i		Ignore errors.
	-m match_string	Match string (default is not defined).
	-v level	Verbosity level (default 1, min 0, max 9).
	--version	Print version.
	directory	Directory with DWG files to test.
END
stderr_is(
	sub {
		App::Test::DWG::LibreDWG::DwgRead->new->run;
		return;
	},
	$right_ret,
	'Run help.',
);
