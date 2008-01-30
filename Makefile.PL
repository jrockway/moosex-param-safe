use inc::Module::Install;

name 'MooseX-Param-Safe';
all_from 'lib/MooseX/Param/Safe.pm';

build_requires 'Test::More';
build_requires 'ok';

WriteAll();
