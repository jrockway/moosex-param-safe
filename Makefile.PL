use inc::Module::Install;

name 'MooseX-Param-Safe';
all_from 'lib/MooseX/Param/Safe.pm';

requires 'Moose::Role';
build_requires 'Moose';
build_requires 'Test::Exception';
build_requires 'Test::More';
build_requires 'ok';

WriteAll();
