package MooseX::RememberHistory;

use warnings;
use strict;

our $VERSION = '0.001';
$VERSION = eval $VERSION;
 
use Moose ();
use Moose::Exporter;

Moose::Exporter->setup_import_methods(
    trait_aliases => [
        [ 'MooseX::RememberHistory::Trait::Attribute' => 'RememberHistory' ],
    ],
);

package Moose::Meta::Attribute::Custom::Trait::RememberHistory;

our $VERSION = '0.001';
$VERSION = eval $VERSION;
    
sub register_implementation { "MooseX::RememberHistory::Trait::Attribute" }

1;

