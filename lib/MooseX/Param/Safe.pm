package MooseX::Param::Safe;
use Moose::Role;
use Carp;

requires 'param';

sub first_param {
    my ($self, $param) = @_;
    my @params = $self->param($param);

    return $params[0];
}

sub list_param {
    my ($self, $param) = @_;
    return [$self->param($param)];
}

sub assert_first_param {
    my ($self, $param) = @_;
    my @params = $self->param($param);
    croak "too many values for param '$param'" if @params > 1;
    return $params[0];
}

1;

__END__

=head1 NAME

MooseX::Param::Safe - safer method of accessing CGI-style C<params>

=head1 SYNOPSIS

Insert rant about how C<< $cgi->params >> is a bad api.

   my $foo = Some::Class->new( params => { 
       foo => 'bar', 
       bar => [qw/
         baz
         is_foo
         1
       /],
   });

   # THE BAD WAY
   my $bar = $foo->param('bar'); # returns "2"
   some_function( bar => $foo->param('bar') );
   # whoops, you said some_function( bar => 'baz', is_foo => 1 );

   # THE GOOD WAY
   MooseX::Param::Safe->meta->apply($foo);
   my $first_bar = $self->first_param('bar'); # baz
   my $all_bar   = $self->list_param('bar');  # [qw/baz is_foo 1/]
   my $first_bar = $self->assert_first_param('bar'); # dies, more than one param
   my $first_foo = $self->assert_first_param('foo'); # bar

=cut

1;
