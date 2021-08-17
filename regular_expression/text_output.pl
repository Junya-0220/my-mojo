use strict;
use warnings;
use utf8;
use open ":utf8";
binmode STDIN, ':encoding(cp932)';
binmode STDOUT, ':encoding(cp932)';
binmode STDERR, ':encoding(cp932)';

open(OK, "> ok.txt") or die("Error:$!");
open(NG, "> ng.txt") or die("Error:$!");

my $ok = "good";
my $ng = "bad";

print OK $ok . "\n";
print OK "こんにちは";
print NG $ng;

# "testvd aybycube"@gmail.com
# "testv<daybycube"@gmail.com
# "testv>daybycube"@gmail.com
# "testv..daybycube"@gmail.com
# ".testvdaybycube"@gmail.com
# "testvdaybycube."@gmail.com
# "testv@daybycube"@gmail.com
# "testv,daybycube"@gmail.com
# "testv[daybycube"@gmail.com
# "testv]daybycube"@gmail.com
# "testv;daybycube"@gmail.com
# "testv:daybycube"@gmail.com
# "testv(daybycube"@gmail.com
# "testv)daybycube"@gmail.com
