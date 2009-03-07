package WebService::Ustream::API::User;

use strict;
use warnings;
use Carp;
use URI::Fetch;
use XML::Simple;

our $VERSION = '0.01';

sub new {
        my($class, %args) = @_;
        $args{fetch} ||= {};
        $args{fetch} = {
                %{$args{fetch}},
                UserAgent => LWP::UserAgent->new( agent => "WebService::Ustream::API::User/$VERSION" )
        };
	bless \%args,$class;
}

sub get {
        my($self, $key, $user) = @_;
        croak('key is required') unless $key;
        croak('user is required') unless $user;

        my $res = URI::Fetch->fetch("http://api.ustream.tv/xml/user/$user/getInfo?key=$key", %{$self->{fetch}});
        croak("Cannot get user information : " . URI::Fetch->errstr) unless $res;

        my $ref;
        eval{$ref = XMLin($res->content)};
        croak('Failed reading user information : ' . $@) if $@;

        return $ref;
}
1;
__END__

=head1 NAME

WebService::Ustream::API::User - Perl interface to Ustream User API Service

=head1 SYNOPSIS

  use WebService::Ustream::API::User;
  
  $ust = WebService::Ustream::API::User->new;
  my $ret = $ust->get('<DevKey>','koba206'); 
  #<DevKey> is API key you receive when you register at http://developer.ustream.tv/apps/register

  print $ret->{results}->{id};
  print $ret->{results}->{registereAt};
  print $ret->{results}->{gender};
  print $ret->{results}->{url};
  print $ret->{results}->{website};
  print $ret->{results}->{about};
  print $ret->{results}->{rating};
  print $ret->{results}->{numberOf}->{comments};
  print $ret->{results}->{numberOf}->{friends};

  print $ret->{error}; #error code
  print $ret->{msg}; #error message

=head1 DESCRIPTION

WebService::Ustream::API::User is a simple interface to Ustream's user information.

=head1 METHODS

=item new

	$ust = WebService::Ustream::API::User->new;
	$ust = WebService::Ustream::API::User->new(fetch=>{
	    Cache=>$c
	});

creates an instace of WebService::Ustream::API::User.

C<fetch> is option for URI::Fetch that used for fetching user information.

=item get(devkey, [username or userid])

	my $ret = $ust->get('<devkey>','koba206');
	my $ret = $ust->get('<devkey>','19185'); #19185 is koba206's userid 

retrieve user information

=head1 SEE ALSO

L<URI::Fetch>
http://developer.ustream.tv/

=head1 AUTHOR

Takeshi Kobayashi, E<lt>koba206@gmail.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2009 by Takeshi Kobayashi

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.8 or,
at your option, any later version of Perl 5 you may have available.


=cut
