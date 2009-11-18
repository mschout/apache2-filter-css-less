use ExtUtils::MakeMaker;

WriteMakefile(
    (MM->can('signature_target') ? (SIGN => 1) : ()),
    NAME              => 'Apache2::Filter::CSS::LESSp',
    VERSION_FROM      => 'lib/Apache2/Filter/CSS/LESSp.pm',
    PREREQ_PM         => {
        'CSS::LESSp' => 0
    },
    ($] >= 5.005 ?
      (ABSTRACT_FROM  => 'lib/Apache2/Filter/CSS/LESSp.pm',
       AUTHOR         => 'Michael J Schout <mschout@cpan.org>') : ()),
);
