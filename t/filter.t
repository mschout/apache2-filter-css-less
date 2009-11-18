#!perl

use strict;
use warnings FATAL => 'all';
use lib qw(t/lib lib);

use Apache::Test ':withtestmore';
use Apache::TestUtil;
use Apache::TestRequest 'GET';
use Test::More;
use My::TestHelper qw(cmp_file_ok read_file);

plan tests => 8, need_lwp;

use_ok('CSS::LESSp') or exit 1;

my $docroot = Apache::Test::vars('documentroot');

# make sure we can get index.html
{
    my $url = '/test.html';
    my $r = GET($url);
    is $r->code, 200;
    cmp_file_ok $r->content, "$docroot/test.html";
}

# filter a .less file
{
    my $url = '/stylesheet.less';
    my $r = GET($url);

    is $r->code, 200;
    is $r->content_type, 'text/css';

    my $expected = join '', CSS::LESSp->parse(
        read_file("$docroot/stylesheet.less"));
    my $got = $r->content;

    $expected =~ s/[\r\n]//g;
    $got      =~ s/[\r\n]//g;

    is $got, $expected, 'less filtering';
}

# check .less.txt is text/plain
{
    my $url = '/stylesheet.less.txt';
    my $r = GET($url);

    is $r->code, 200;
    is $r->content_type, 'text/plain';
}
