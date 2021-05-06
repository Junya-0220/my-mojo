#!/usr/bin/perl
use strict;
use warnings;
no warnings 'once';
use utf8;
use Encode;
binmode STDIN, ':encoding(cp932)';
binmode STDOUT, ':encoding(cp932)';
binmode STDERR, ':encoding(cp932)';

open(OK, "> ok.txt") or die("Error:$!");
open(NG, "> ng.txt") or die("Error:$!");


#OKのケースの配列
my @mocks = (
	"testv.daybycube\@gmail.com",
	"testv-daybycube\@gmail.com",
	"testv\%daybycube\@gmail.com",
	"testv'daybycube\@gmail.com",
	"testv#daybycube\@gmail.com",
	"testv&daybycube\@gmail.com",
	"testv!daybycube\@gmail.com",
	"testv(daybycube\@gmail.com",
	"testv)daybycube\@gmail.com",
	"testv~daybycube\@gmail.com",
	"testv|daybycube\@gmail.com",
	"testv[daybycube\@gmail.com",
	"testv]daybycube\@gmail.com",
	"testv{daybycube\@gmail.com",
	"testv}daybycube\@gmail.com",
	"testv;daybycube\@gmail.com",
	"testv:daybycube\@gmail.com",
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
  "\"testv<daybycube\"\@gmail.com",
	"\"testv>daybycube\"\@gmail.com",
	"\"testv..daybycube\"\@gmail.com",
	"\".testvdaybycube\"\@gmail.com",
	"\"testvdaybycube.\"\@gmail.com",
	"\"testvd aybycube\"\@gmail.com",
);

foreach  my $mock (@mocks) {
  my $ret = &check_addr($mock);
  if ($ret != 1) {
    printf(NG "ng addr :%s\n", $mock);
  } else {
    printf(OK "ok addr :%s\n", $mock);
  }
}

#NGのケースの配列
my @ng_mocks = (
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
	"\"test5vdaybycube\"",
	"\"abcd\"",
	"\"\"",
);


foreach  my $mock (@ng_mocks) {
  my $ret = &check_addr($mock);
  if ($ret == 0) {
    printf(NG "ng addr :%s\n", $mock);
  } else {
		my $mock = decode( 'utf-8', $mock );
    printf(OK "ok addr :%s\n", $mock);
  }
}

# ここの関数を作成
# 正規表現が問題なくメールアドレスをチェックできているかを確認する。
#https://ja.wikipedia.org/wiki/%E3%83%A1%E3%83%BC%E3%83%AB%E3%82%A2%E3%83%89%E3%83%AC%E3%82%B9
# 引用した正規表現(一番最初)https://tech.katsubemakito.net/perl/expr_isemailaddress
# 引用した正規表現(2回目)https://www.javadrive.jp/regex-basic/sample/index13.html
# todo ""(ダブルクオーテーション)で囲った(45～50行目)メールアドレスはOKのリストに行くように修正を加える
# todo ''(シングルクオーテーション)で囲った(38～43行目)メールアドレスはOKのリストに行くように修正を加える
# todo 半角スペースが入っていたらNGに入れる
# todo 途中に"が1つで入っていたらNGに入れる
sub check_addr() {
  my ($address) = @_;
	if($address =~ /^[a-zA-Z0-9_+-]+(.[a-zA-Z0-9_+-]+)*@([a-zA-Z0-9][a-zA-Z0-9-]*[a-zA-Z0-9]*\.)+[a-zA-Z]{2,}$/){

		return 1;
	}else{
		return 0;
	}
	#1回で終わらなかったら処理を以下に追加していく。
}
