use 5.008008;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME              => 'WebService::Ustream::API::User',
    VERSION_FROM      => 'lib/WebService/Ustream/API/User.pm', # finds $VERSION
    PREREQ_PM         => {
	'URI::Fetch' => 0,
	'XML::Simple' => 0
    },
    ($] >= 5.005 ?
      (ABSTRACT_FROM  => 'lib/WebService/Ustream/API/User.pm',
       AUTHOR         => 'Takeshi Kobayashi <tkobayashi@>') : ()),
);
