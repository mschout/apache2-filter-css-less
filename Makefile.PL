require 5.008;

use ExtUtils::MakeMaker;

use lib qw(../blib/lib lib);

use Apache::TestMM qw(test clean);    # enable make test

my @scripts = qw(t/TEST);

Apache::TestMM::filter_args();
Apache::TestMM::generate_script('t/TEST');

my $mm_version = $ExtUtils::MakeMaker::VERSION;

WriteMakefile(
    (MM->can('signature_target') ? (SIGN => 1) : ()),
    NAME              => 'Apache2::Filter::CSS::LESSp',
    VERSION_FROM      => 'lib/Apache2/Filter/CSS/LESSp.pm',
    PREREQ_PM => {
        'mod_perl2'    => '1.9922',   # 2.0 RC5
        'CSS::LESSp'   => 0,
        'Apache::Test' => 0
    },
    clean             => {
        FILES => "@{ clean_files() }"
    },
    ($] >= 5.005 ? (
        ABSTRACT_FROM  => 'lib/Apache2/Filter/CSS/LESSp.pm',
        AUTHOR         => 'Michael J Schout <mschout@cpan.org>'
    ) : ()),
    ($mm_version >= 6.48 ? (
        META_MERGE      => {
            no_index => {
                directory => [qw(t)],
            },
            resources => {
                bugtracker  => 'http://rt.cpan.org/NoAuth/Bugs.html?Dist=Apache2-Filter-CSS-LESSp',
                repository  => 'http://github.com/mschout/apache2-filter-css-lessp',
            },
        },
    ) : ()),
);

sub clean_files {
    return [@scripts];
}
