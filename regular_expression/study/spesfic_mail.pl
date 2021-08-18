#!/usr/bin/perl
use strict;
use warnings;
no warnings 'once';
use utf8;
use Encode;


# local_partパートを作成する。
my $wsp           = '[\x20\x09]'; # 半角空白と水平タブ
my $vchar         = '[\x21-\x7e]'; # ASCIIコードの ! から ~ まで
my $quoted_pair   = "\\\\(?:$vchar|$wsp)"; #\ を前につけた quoted-pair 形式なら \ と " が使用できる
my $qtext         = '[\x20\x23-\x5b\x5d-\x7e]'; #$vchar から \ と " を抜いたもの。\x22 は " , \x5c は\
my $qcontent      = "(?:$qtext|$quoted_pair)"; #quoted-string 形式の条件分岐
my $quoted_string = "\"$qcontent*\""; # " で 囲まれた quoted-string 形式。
print("quoted_string: $quoted_string\n");
my $atext         = '[a-zA-Z0-9!#$%&\'*+\-\/\=?^_`{|}~]'; #通常、メールアドレスに使用出来る文字
my $dot_atom_text = "$atext+(?:[.]$atext+)*"; #ドットが連続しない RFC 準拠形式をループ展開で構築
my $dot_atom      = $dot_atom_text;

# domainパートを作成する。　dot_atomで許容してる文字が多すぎて、通してはいけない文字もマッチしている事が問題。
my $atext2         = '[a-zA-Z0-9*+\-`]'; #通常、メールアドレスに使用出来る文字
my $dot_atom_text2 = "$atext2+(?:[.]$atext2+)*"; #ドットが連続しない RFC 準拠形式をループ展開で構築
my $dot_atom2      = $dot_atom_text2;
my $domain        = $dot_atom2;

# print("dot_atom: $dot_atom\n");
# print("quoted_string: $quoted_string\n");
my $local_part    = "(?:$dot_atom|$quoted_string)"; #local-part は dot-atom 形式 または quoted-string 形式のどちらかドメイン部分の判定強化
my $addr_spec     = qr{${local_part}[@]$domain}; #合成
print("addr_spec: $addr_spec\n");
print("local: $local_part\n");
# print("domain: $domain\n");


my @mock = (

	"\"testvd aybycube\"\@gmail.com",
  "\"testv<daybycube\"\@gmail.com",
	"\"testv>daybycube\"\@gmail.com",
	"\"testv..daybycube\"\@gmail.com",
	"\".testvdaybycube\"\@gmail.com",
	"\"testvdaybycube.\"\@gmail.com",
	"\"testv\@daybycube\"\@gmail.com",
	"\"testv\,daybycube\"\@gmail.com",
	"\"testv[daybycube\"\@gmail.com",
	"\"testv]daybycube\"\@gmail.com",
	"\"testv;daybycube\"\@gmail.com",
	"\"testv:daybycube\"\@gmail.com",
	"\"testv(daybycube\"\@gmail.com",
	"\"testv)daybycube\"\@gmail.com",


);

foreach my $check_addr(@mock){
	my $input_addr_spec = $check_addr;

if ( $input_addr_spec =~ /\A$addr_spec\z/ ) {
    # print "good $input_addr_spec\n";
}else{
	# print "bad $input_addr_spec\n";
}

}


# my $input_text = 'ぼくの@メールアドレスはfoo@example.comです';
# if ( $input_text =~ /($addr_spec)/ ) {
#     print "My addr-spec is <$1>\n";
# }
