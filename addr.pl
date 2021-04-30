#!/usr/bin/perl
use strict;
use warnings;
no warnings 'once';
use utf8;

#OKのケースの配列 テスト変更
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

#check_addrを実行して1を返せばOK
foreach  my $mock (@mocks) {
  my $ret = &check_addr($mock);
  if ($ret != 1) {
    die sprintf("ng addr :%s\n", $mock);
  } else {
    printf("ok addr :%s\n", $mock);
  }
}

#NGのケースの配列
my @ng_mocks = (
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

#check_addrを実行して0を返せばOK
foreach  my $mock (@ng_mocks) {
  my $ret = &check_addr($mock);
  if ($ret != 0) {
    die sprintf("ng addr :%s\n", $mock);
  } else {
    printf("ok addr :%s\n", $mock);
  }
}

# ここの関数を作成
# 正規表現が問題なくメールアドレスをチェックできているかを確認する。
#https://ja.wikipedia.org/wiki/%E3%83%A1%E3%83%BC%E3%83%AB%E3%82%A2%E3%83%89%E3%83%AC%E3%82%B9
sub check_addr() {
  my ($address) = @_;
	if(/^([a-zA-Z0-9\.\-\/_]{1,})@([a-zA-Z0-9\.\-\/_]{1,})\.([a-zA-Z0-9\.\-\/_]{1,})$/){
		$address　がただしい。


  	return 1;
	}else{


		return 0;
	}

	#1回で終わらなかったら処理を以下に追加していく。

}
