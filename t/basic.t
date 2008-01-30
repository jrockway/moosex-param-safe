use strict;
use warnings;
use Test::Exception;
use Test::More tests => 9;

{ 
    package Foo;
    use Moose;
    with 'MooseX::Param::Safe';

    has 'params' => ( is => 'rw', isa => 'HashRef', required => 1);

    sub param {
        my ($self, $param) = @_;
        my $result = $self->params->{$param};

        return @$result if ref $result;
        return $result;
    }
}

my $a = Foo->new( params => { foo => 'bar', bar => [qw/baz quux gorch/] } );

# old API
is_deeply [$a->param('foo')], [qw/bar/];
is_deeply [$a->param('bar')], [qw/baz quux gorch/];

# safe API
is $a->first_param('foo'), 'bar';
is $a->first_param('bar'), 'baz';
is_deeply $a->list_param('foo'), [qw/bar/];
is_deeply $a->list_param('bar'), [qw/baz quux gorch/];

lives_ok {
    is $a->assert_first_param('foo'), 'bar';
} 'assert_first_param foo lives ok';

throws_ok {
    $a->assert_first_param('bar');
} qr/too many values for param 'bar'/, 'assert_first_param bar dies';
