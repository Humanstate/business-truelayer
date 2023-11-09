# NAME

Business::TrueLayer - Perl library for interacting with the TrueLayer v3 API
(https://docs.truelayer.com/)

# VERSION

v0.01

# SYNOPSIS

    my $TrueLayer = Business::TrueLayer->new(

        # required constructor arguments
        client_id     => $truelayer_client_id,
        client_secret => $truelauer_client_secret,
        kid           => $truelayer_kid,
        private_key   => '/path/to/private/key',

        # optional constructor arguments (with defaults)
        host          => 'truelayer.com',
        api_host      => 'api.truelayer.com',
        auth_host     => 'auth.truelayer.com',
    );

    # valid your setup (neither required in live usage):
    $TrueLayer->test_signature;
    my $access_token = $TrueLayer->access_token;

    # create a payment
    my $Payment = $TrueLayer->create_payment( $args );
    my $link    = $Payment->hosted_payment_page_link( $redirect_uri );

    # get status of a payment
    my $Payment = $TrueLayer->get_payment( $payment_id );

    if ( $Payment->settled ) {
        ...
    }

# DESCRIPTION

[Business::TrueLayer](https://metacpan.org/pod/Business%3A%3ATrueLayer) is a client library for interacting with the
TrueLayer v3 API. It implementes the necesary signing and transport logic
to allow you to just focus on just the endpoints you want to call.

The initial version of this distribution supports just those steps that
described at [https://docs.truelayer.com/docs/quickstart-make-a-payment](https://docs.truelayer.com/docs/quickstart-make-a-payment)
and others will be added as necessary (pull requests also welcome).

# DEBUGGING

Set `MOJO_CLIENT_DEBUG=1` for user agent and transport debug output.

# METHODS

## test\_signature

Tests if your signature and signing is valid.

    $TrueLayer->test_signature;

Returns 1 on success, throws an exception otherwise.

## access\_token

Get an access token.

    my $access_token = $TrueLayer->access_token;

Returns an access token on success, throws an exception otherwise.

## merchant\_accounts

Get a list of merchant accounts, `$id` is optional to specifiy just one.

    my @merchant_accounts = $TrueLayer->merchant_accounts( $id );

Returns a list of [Business::TrueLayer::MerchantAccount](https://metacpan.org/pod/Business%3A%3ATrueLayer%3A%3AMerchantAccount) objects.

## create\_payment

Instantiates a [Business::TrueLayer::Payment](https://metacpan.org/pod/Business%3A%3ATrueLayer%3A%3APayment) object then calls the
API to create it - will return the object to allow you to inspect it
and call methods on it.

    my $Payment = $TrueLayer->create_payment( $args );

`$args` should be a hash reference of the necessary attributes to
instantiate a [Business::TrueLayer::Payment](https://metacpan.org/pod/Business%3A%3ATrueLayer%3A%3APayment) object - see the perldoc
for that class for the attributes required.

Any issues here will result in an exception being thrown.

## get\_payment

Calls the API to get the details for a payment for the given id then
instantiates a [Business::TrueLayer::Payment](https://metacpan.org/pod/Business%3A%3ATrueLayer%3A%3APayment) object for return to
the caller

    my $Payment = $TrueLayer->get_payment( $payment_id );

Any issues here will result in an exception being thrown.

# SEE ALSO

[Business::TrueLayer::MerchantAccount](https://metacpan.org/pod/Business%3A%3ATrueLayer%3A%3AMerchantAccount)

[Business::TrueLayer::Payment](https://metacpan.org/pod/Business%3A%3ATrueLayer%3A%3APayment)
