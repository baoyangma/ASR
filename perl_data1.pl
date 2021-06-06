use strict;
use 5.010;
print "hello perl\n";

my @a = 1..10;
#print "$#a";

foreach $b (@a)
{
    print $b;
}

print "\n";

sub max
{
    state $index=0;
    $index+=1; 
    my$num = @_;
    my$maxRes = shift@_;
    print "$num\n";

    my($c,$d);
    #foreach $t(@_)
    #{
    #if($maxRes < $t)
    #{
    #$maxRes = $t;
    #}
    #}
    foreach (@_)
    {
        if($maxRes<$_)
        {
            $maxRes=$_;
        }
    }
    $maxRes;
}

my $res = &max(10,15,20);
#print $res;


#while(<STDIN>)
#{
#chomp;
#print "this is $_\n";
#}

my $lines;
#while($lines=<>)
#{
#chomp($lines);
#print "this is $lines\n";
#}

# 钻石操作符读的是@ARGV这个数组，@ARGV里面的是调用参数
#@ARGV = qw/a.txt/;#读a.txt文件
#while(<>)
#{
#chomp;
#print "this is $_\n";
#}
#
#say "this is say function test!";


if(!open TXTFILE,"<","a.txt"){die "打开文件失败:$!"};
while(<TXTFILE>)
{
    printf "$_";
}
close TXTFILE;

print "\n";

open TXTFILE,">>","b.txt";# ">"表示覆盖;   ">>"表示append
print  TXTFILE "hello perl";
close  TXTFILE;


# 哈希里面的数被读出来时，顺序是随机的
 my %hash = ("a" => 1,"b" => 2,"c" => 3);
 my $key;
 my $value;
 while(($key,$value) = each %hash)
 {
    print "$key = $value\n";
 }

 foreach $key (keys %hash)
 {
    print "$key = $hash{$key}\n";
 }

 if(exists $hash{"b"})
 {
    print "存在要找的key" . "\n";
 }
 else
 {
    print "不存在要找的key" . "\n";
 }

 delete $hash{"b"};

my $k;
my $v;
open ENV_FILE , ">" ,"env.txt";
while (($k,$v)=each %ENV)
{
    #print "$k = $v" . "\n";
    print ENV_FILE "$k = $v" . "\n";
}
