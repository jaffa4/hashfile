
use lib 'lib';
use Hash::File;
use Test;

my $h = Hash::File.new;
my $hash =  $h.get-hash: $?FILE,"MD5";
#say ">>$hash\<\<";
ok $hash.chars==40,"size of MD5";

done-testing;
