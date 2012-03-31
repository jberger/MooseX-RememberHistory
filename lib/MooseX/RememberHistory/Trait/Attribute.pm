package MooseX::RememberHistory::Trait::Attribute;

use Moose::Role;

our $VERSION = '0.001';
$VERSION = eval $VERSION;

has 'history_getter' => (
  isa => 'Str',
  is  => 'ro',
  lazy => 1,
  builder => '_history_name',
);

sub _history_name {
  my $attr = shift;
  my $name = $attr->name;
  return $name . '_history';
}

around 'install_accessors' => sub { 
  my $orig = shift;
  my $attr = shift;

  my $class = $attr->associated_class;
  my $hist_name = $attr->history_getter;
  
  #add history holder
  $class->add_attribute(
    $hist_name => (
      is => 'rw',
      isa => 'ArrayRef',
      default => sub { [] },
    ),
  );

  $attr->$orig(@_);

  my $writer_name = $attr->get_write_method;

  $class->add_after_method_modifier($writer_name, sub{
    my ($self, $value) = @_;
    return unless defined $value;
    my $history = $self->can($hist_name)->($self);
    push @$history, $value;
  });
};

1;

