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

# ��ʯ������������@ARGV������飬@ARGV������ǵ��ò���
#@ARGV = qw/a.txt/;#��a.txt�ļ�
#while(<>)
#{
#chomp;
#print "this is $_\n";
#}
#
#say "this is say function test!";


if(!open TXTFILE,"<","a.txt"){die "���ļ�ʧ��:$!"};
while(<TXTFILE>)
{
    printf "$_";
}
close TXTFILE;

print "\n";

open TXTFILE,">>","b.txt";# ">"��ʾ����;   ">>"��ʾappend
print  TXTFILE "hello perl";
close  TXTFILE;


# ��ϣ���������������ʱ��˳���������
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
    print "����Ҫ�ҵ�key" . "\n";
 }
 else
 {
    print "������Ҫ�ҵ�key" . "\n";
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
