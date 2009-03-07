# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl WebService-Ustream-API-User.t'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test::More tests => 3;
BEGIN { use_ok('WebService::Ustream::API::User') };

#########################

my $ust = WebService::Ustream::API::User->new();

isa_ok($ust, "WebService::Ustream::API::User");
can_ok($ust, "get");
