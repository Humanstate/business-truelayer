package Business::TrueLayer::Types;

use strict;
use warnings;

use Moose::Util::TypeConstraints;

# UserAgent can be a Test::MockObject so we can do "end to end"
# testing without actually going out on the wire
subtype 'UserAgent'
    => as 'Object'
    => where {
        $_->isa( 'Mojo::UserAgent' )
        or $_->isa( 'Test::MockObject' )
    }
;

subtype 'Authenticator'
    => as 'Object'
    => where {
        $_->isa( 'Business::TrueLayer::Authenticator' )
    }
;

subtype 'Signer'
    => as 'Object'
    => where {
        $_->isa( 'Business::TrueLayer::Signer' )
    }
;

subtype 'EC512:PrivateKey'
    => as 'Object'
    => where {
        $_->isa( 'Crypt::PK::ECC' )
    }
;

coerce 'EC512:PrivateKey'
    => from 'Value'
    => via {
        Crypt::PK::ECC->new( $_ )
    }
;

1;

# vim: ts=4:sw=4:et
