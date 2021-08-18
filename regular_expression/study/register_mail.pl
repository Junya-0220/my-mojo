#!/usr/bin/perl
use strict;
use warnings;
no warnings 'once';
use utf8;
use Encode;


sub register_mailaddress {
	# local_partパートを作成する。
	my ($address) = @_;
	my $atext         = '[a-zA-Z0-9!#$%&\'*+\-\/\=?^_`{|}~]'; #通常、メールアドレスに使用出来る文字
	my $dot_atom_text = "$atext+(?:[.]$atext+)*"; #ドットが連続しない RFC 準拠形式をループ展開で構築
	my $dot_atom      = $dot_atom_text;

	# domainパートを作成する。　dot_atomで許容してる文字が多すぎて、通してはいけない文字もマッチしている事が問題。
	my $atext2         = '[a-zA-Z0-9*+\-`]'; #通常、メールアドレスに使用出来る文字
	my $dot_atom_text2 = "$atext2+(?:[.]$atext2+)*"; #ドットが連続しない RFC 準拠形式をループ展開で構築
	my $dot_atom2      = $dot_atom_text2;
	my $domain        = $dot_atom2;

	my $local_part    = "(?:$dot_atom)"; #local-part は dot-atom 形式 または quoted-string 形式のどちらかドメイン部分の判定強化
	my $addr_spec     = qr{${local_part}[@]$domain}; #合成
	if ( $address =~ /\A$addr_spec\z/ ) {
		return 1;
	}else{
		return 0;
	}
}




my @mock = (

	"testv.daybycube\@gmail.com",
	"testv-daybycube\@gmail.com",
	"testv\%daybycube\@gmail.com",
	"testv'daybycube\@gmail.com",
	"testv#daybycube\@gmail.com",
	"testv&daybycube\@gmail.com",
	"testv!daybycube\@gmail.com",
	"testv~daybycube\@gmail.com",
	"testv|daybycube\@gmail.com",
	"testv{daybycube\@gmail.com",
	"testv}daybycube\@gmail.com",
	"testv/daybycube\@gmail.com",
	"testv=daybycube\@gmail.com",
	"testv?daybycube\@gmail.com",
	"testv_daybycube\@gmail.com",
	"testv'daybycube\@gmail.com",
	"testv''daybycube\@gmail.com",
	"testv''daybycube\@gmailtest.com",
	"testv''daybycube\@gmail.test.com",
	"testv''daybycube\@gm.ail.te.st.com",
	"'testv''daybycube'\@gmail.com",
	"testv.d.a.y.bycube\@gmail.com",
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

	"testv\@daybycube\@gmail.com",
	"testv\,daybycube\@gmail.com",
	"testv[daybycube\@gmail.com",
	"testv]daybycube\@gmail.com",
	"testv;daybycube\@gmail.com",
	"testv:daybycube\@gmail.com",
	"testv(daybycube\@gmail.com",
	"testv)daybycube\@gmail.com",
	"testv.ーaybycube\@gmail.com",
	"testv.あaybycube\@gmail.com",
	"testv..daybycube\@gmail.com",
	".testvdaybycube\@gmail.com",
	"testvdaybycube.\@gmail.com",
	"testv<daybycube\@gmail.com",
	"testv>daybycube\@gmail.com",
	"testv..daybycube\@gmail.com",
	"testv...daybycube\@gmail.com",
	"..testvdaybycube\@gmail.com",
	"................\@gmail.com",
	"testvdaybycube..\@gmail.com",
	".testvdaybycube\@gmail.com",
	"testvdaybycube.\@gmail.com",
	"testvd aybycube\@gmail.com",
	"test5vdaybycube",
	"abcd",
	"",
	"testv\"daybycube\@gmail.com",
	"testv\"\"daybycube\@gmail.com",
	"\"testvd aybycube\"\@gma\"il.com",
	"\"testvd aybycube\"\@gma\@il.com",
	"\"testvd aybycube\"\@gma&il.com",
	"\"testvd aybycube\"\@gma!il.com",
	"\"testvd aybycube\"\@gma#il.com",
	"\"testvd aybycube\"\@gma\$il.com",
	"\"testvd aybycube\"\@gma\%il.com",
	"\"testvd aybycube\"\@gma'il.com",
	"\"testvd aybycube\"\@gma(il.com",
	"\"testvd aybycube\"\@gma)il.com",
	"\"testvd aybycube\"\@gma=il.com",
	"\"testvd aybycube\"\@gma~il.com",
	"\"testvd aybycube\"\@gma|il.com",
	"\"testvd aybycube\"\@gma^il.com",
	"\"testvd aybycube\"\@gma;il.com",
	"\"testvd aybycube\"\@gma:il.com",
	"\"testvd aybycube\"\@gma[il.com",
	"\"testvd aybycube\"\@gma]il.com",
	"\"testvd aybycube\"\@gma{il.com",
	"\"testvd aybycube\"\@gma}il.com",
	"\"testvd aybycube\"\@gma/il.com",
	"\"testvd aybycube\"\@gma\\il.com",
	"\"testvd aybycube\"\@gma,il.com",
	"\"testvd aybycube\"\@gma<il.com",
	"\"testvd aybycube\"\@gma>il.com",
	"\"testvd aybycube\"\@gma?il.com",
	"\"testvd aybycube\"\@gma_il.com",
	"\"testvdaybycube\"\@gma\"il.com",
	"\"testvdaybycube\"\@gma\@il.com",
	"\"testvdaybycube\"\@gma&il.com",
	"\"testvdaybycube\"\@gma!il.com",
	"\"testvdaybycube\"\@gma#il.com",
	"\"testvdaybycube\"\@gma\$il.com",
	"\"testvdaybycube\"\@gma\%il.com",
	"\"testvdaybycube\"\@gma'il.com",
	"\"testvdaybycube\"\@gma(il.com",
	"\"testvdaybycube\"\@gma)il.com",
	"\"testvdaybycube\"\@gma=il.com",
	"\"testvdaybycube\"\@gma~il.com",
	"\"testvdaybycube\"\@gma|il.com",
	"\"testvdaybycube\"\@gma^il.com",
	"\"testvdaybycube\"\@gma;il.com",
	"\"testvdaybycube\"\@gma:il.com",
	"\"testvdaybycube\"\@gma[il.com",
	"\"testvdaybycube\"\@gma]il.com",
	"\"testvdaybycube\"\@gma{il.com",
	"\"testvdaybycube\"\@gma}il.com",
	"\"testvdaybycube\"\@gma/il.com",
	"\"testvdaybycube\"\@gma\\il.com",
	"\"testvdaybycube\"\@gma,il.com",
	"\"testvdaybycube\"\@gma<il.com",
	"\"testvdaybycube\"\@gma>il.com",
	"\"testvdaybycube\"\@gma?il.com",
	"\"testvdaybycube\"\@gma_il.com",

	"\"testvdaybycube\"\@gmail.com.",
	"\"testvdaybycube\"\@.gmail.com",
	"\"testvdaybycube\"\@gm..ail.com",
	"\"test5vdaybycube\"",
	"\"abcd\"",
	"\"\"",



);

foreach my $check_addr(@mock){
	my $input_addr_spec = $check_addr;

if ( &check_mailaddress($input_addr_spec) ) {
    print "good $input_addr_spec\n";
}else{
	print "bad $input_addr_spec\n";
}

}
